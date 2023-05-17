package com.ste4o26.cookviser_rest_api.services;

import com.ste4o26.cookviser_rest_api.domain.entities.CuisineEntity;
import com.ste4o26.cookviser_rest_api.domain.entities.RecipeEntity;
import com.ste4o26.cookviser_rest_api.domain.entities.StepEntity;
import com.ste4o26.cookviser_rest_api.domain.entities.enums.CategoryName;
import com.ste4o26.cookviser_rest_api.domain.service_models.CuisineServiceModel;
import com.ste4o26.cookviser_rest_api.domain.service_models.RecipeServiceModel;
import com.ste4o26.cookviser_rest_api.domain.service_models.StepServiceModel;
import com.ste4o26.cookviser_rest_api.domain.service_models.UserServiceModel;
import com.ste4o26.cookviser_rest_api.exceptions.RecipeNotExistsException;
import com.ste4o26.cookviser_rest_api.exceptions.SearchValueNotProvidedException;
import com.ste4o26.cookviser_rest_api.exceptions.UserNotAuthenticatedException;
import com.ste4o26.cookviser_rest_api.repositories.RecipeRepository;
import com.ste4o26.cookviser_rest_api.services.interfaces.*;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static com.ste4o26.cookviser_rest_api.init.ErrorMessages.*;

@Service
public class RecipeServiceImpl implements RecipeService {
    private final RecipeRepository recipeRepository;
    private final ModelMapper modelMapper;
    private final UserService userService;
    private final StepService stepService;
    private final RateService rateService;

    @Autowired
    public RecipeServiceImpl(RecipeRepository recipeRepository, ModelMapper modelMapper, UserService userService, StepService stepService, RateService rateService) {
        this.recipeRepository = recipeRepository;
        this.modelMapper = modelMapper;
        this.userService = userService;
        this.stepService = stepService;
        this.rateService = rateService;
    }

    @Override
    public RecipeServiceModel persist(RecipeServiceModel recipeServiceModel, Principal principal)
            throws UserNotAuthenticatedException {
        if (principal.getName() == null || principal.getName().trim().isEmpty()) {
            throw new UserNotAuthenticatedException(FORBIDDEN_MESSAGE);
        }

        UserServiceModel publisher = this.userService.fetchByUsername(principal.getName());
        recipeServiceModel.setPublisher(publisher);
        recipeServiceModel.setRates(new HashSet<>());
        recipeServiceModel.setCookedBy(new HashSet<>());

        Set<StepServiceModel> createdSteps = recipeServiceModel.getSteps()
                .stream()
                .map(this.stepService::persist)
                .collect(Collectors.toSet());

        recipeServiceModel.setSteps(createdSteps);

        RecipeEntity recipeEntity = this.modelMapper.map(recipeServiceModel, RecipeEntity.class);
        RecipeEntity persisted = this.recipeRepository.saveAndFlush(recipeEntity);

        return this.modelMapper.map(persisted, RecipeServiceModel.class);
    }

    @Override
    public RecipeServiceModel fetchById(String id) throws RecipeNotExistsException {
        RecipeEntity recipeEntity = this.recipeRepository.findById(id)
                .orElseThrow(() -> new RecipeNotExistsException(String.format(RECIPE_NOT_EXISTS, id)));

        return this.modelMapper.map(recipeEntity, RecipeServiceModel.class);
    }

    @Override
    public RecipeServiceModel deleteById(String id) throws RecipeNotExistsException {
        RecipeServiceModel recipeServiceModel = this.fetchById(id);
        this.recipeRepository.deleteById(id);
        return recipeServiceModel;
    }

    @Override
    public RecipeServiceModel update(RecipeServiceModel newData) throws RecipeNotExistsException {

        Set<StepEntity> updatedSteps = newData.getSteps()
                .stream()
                .map(this.stepService::persist)
                .map(step -> modelMapper.map(step, StepEntity.class))
                .collect(Collectors.toSet());
        RecipeEntity recipe = this.recipeRepository.findById(newData.getId())
                .orElseThrow(() -> new RecipeNotExistsException(String.format(RECIPE_NOT_EXISTS, newData.getId())));

        recipe.setName(newData.getName());
        recipe.setDescription(newData.getDescription());
        recipe.setIngredients(newData.getIngredients());
        recipe.setSteps(updatedSteps);
        recipe.setCategory(newData.getCategory());
        recipe.setRatingOverall(newData.getOverallRating());

        if (newData.getRecipeThumbnail() != null) {
            recipe.setRecipeThumbnail(newData.getRecipeThumbnail());
        }

        recipe = recipeRepository.saveAndFlush(recipe);

        return this.modelMapper.map(recipe, RecipeServiceModel.class);
    }

    @Override
    public List<RecipeServiceModel> fetchBestFourOrderByRates() {
        return recipeRepository.fetchBestFour().stream()
                .map(recipe -> this.modelMapper.map(recipe, RecipeServiceModel.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<RecipeServiceModel> fetchAll() {
        List<RecipeEntity> allRecipes = this.recipeRepository.findAll();
        return RecipeServiceModel.mapFrom(allRecipes, this.modelMapper);
    }

    @Override
    public List<RecipeServiceModel> fetchNextByCuisine(
            CuisineServiceModel cuisineServiceModel,
            Integer pageNumber,
            Integer recipesCount
    ) {
        CuisineEntity cuisineEntity = this.modelMapper.map(cuisineServiceModel, CuisineEntity.class);
        List<RecipeEntity> allByCuisine = this.recipeRepository.findAllByCuisine(
                cuisineEntity,
                PageRequest.of(pageNumber, recipesCount)
        );
        return RecipeServiceModel.mapFrom(allByCuisine, this.modelMapper);
    }

    @Override
    public List<RecipeServiceModel> fetchNextRecipes(Integer pageNumber, Integer recipesCount) {
        List<RecipeEntity> nextPage = this.recipeRepository.findAll(PageRequest.of(pageNumber, recipesCount)).toList();
        return RecipeServiceModel.mapFrom(nextPage, this.modelMapper);
    }

    @Override
    public List<RecipeServiceModel> fetchAllContains(String searchValue) throws SearchValueNotProvidedException {
        if (searchValue == null || searchValue.trim().isEmpty()) {
            throw new SearchValueNotProvidedException(BLANK_SEARCH_VALUE_MESSAGE);
        }

        List<RecipeEntity> allBySearchedValue = this.recipeRepository.findAllByNameContaining(searchValue);
        return RecipeServiceModel.mapFrom(allBySearchedValue, modelMapper);
    }

    @Override
    public RecipeServiceModel addToCooked(String recipeId, Principal principal)
            throws UserNotAuthenticatedException, RecipeNotExistsException {
        if (principal.getName() == null || principal.getName().trim().isEmpty()) {
            throw new UserNotAuthenticatedException(FORBIDDEN_MESSAGE);
        }

        UserServiceModel userServiceModel = this.userService.fetchByUsername(principal.getName());
        RecipeServiceModel recipeServiceModel = this.fetchById(recipeId);

        userServiceModel.getMyCookedRecipes().add(recipeServiceModel);
        this.userService.update(userServiceModel);

        return recipeServiceModel;
    }
}
