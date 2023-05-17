package com.ste4o26.cookviser_rest_api.services;

import com.ste4o26.cookviser_rest_api.domain.entities.RateEntity;
import com.ste4o26.cookviser_rest_api.domain.entities.RecipeEntity;
import com.ste4o26.cookviser_rest_api.domain.entities.UserEntity;
import com.ste4o26.cookviser_rest_api.domain.service_models.RateServiceModel;
import com.ste4o26.cookviser_rest_api.repositories.RateRepository;
import com.ste4o26.cookviser_rest_api.repositories.RecipeRepository;
import com.ste4o26.cookviser_rest_api.repositories.UserRepository;
import com.ste4o26.cookviser_rest_api.services.interfaces.RateService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class RateServiceImpl implements RateService {
    private final RateRepository rateRepository;
    private final ModelMapper modelMapper;

    private final RecipeRepository recipeRepository;

    private final UserRepository userRepository;

    @Autowired
    public RateServiceImpl(RateRepository rateRepository, ModelMapper modelMapper, RecipeRepository recipeRepository, UserRepository userRepository) {
        this.rateRepository = rateRepository;
        this.modelMapper = modelMapper;
        this.recipeRepository = recipeRepository;
        this.userRepository = userRepository;
    }

    public List<RateServiceModel> fetchAll() {
        return rateRepository.findAll().stream()
                .map(entity -> modelMapper.map(entity, RateServiceModel.class))
                .collect(Collectors.toList());
    }

    @Override
    public RateServiceModel rate(RateServiceModel rateServiceModel) {
        String userId = rateServiceModel.getUser().getId();
        String recipeId = rateServiceModel.getRecipe().getId();
        Optional<RateEntity> oldRateOpt = this.rateRepository.findByUserIdAndRecipeId(userId, recipeId);

        RateEntity rateEntity;
        RecipeEntity recipe;
        int ratesCount;
        double ratesSum;
        double overall;
        if (oldRateOpt.isEmpty()) {
            rateEntity = this.modelMapper.map(rateServiceModel, RateEntity.class);
            recipe = recipeRepository.findById(recipeId).orElseThrow();

            ratesCount = recipe.getRates().size();
            ratesSum = recipe.getRatingOverall() * ratesCount;
            overall = calculateRatingOverall(ratesSum, ratesCount + 1, 0, rateServiceModel.getRateValue());
        } else {
            rateEntity = oldRateOpt.get();
            recipe = rateEntity.getRecipe();
            ratesCount = recipe.getRates().size();
            ratesSum = recipe.getRatingOverall() * ratesCount;
            overall = calculateRatingOverall(ratesSum, ratesCount, rateEntity.getRateValue(), rateServiceModel.getRateValue());
        }


        UserEntity publisher = recipe.getPublisher();
        recipe.setPublisher(publisher);
        publisher.getMyRecipes().add(recipe);

        rateEntity.setRateValue(rateServiceModel.getRateValue());
        rateEntity.setRecipe(recipe);
        recipe.getRates().add(rateEntity);

        ratesCount = (int) publisher.getMyRecipes().stream().filter(rec -> rec.getRates().size() != 0).count();
        ratesSum = publisher.getRatingOverall() * ratesCount;
        double publisherOverall = calculateRatingOverall(ratesSum, ratesCount, recipe.getRatingOverall(), overall);


        recipe.setRatingOverall(overall);
        publisher.setRatingOverall(publisherOverall);


        userRepository.saveAndFlush(publisher);
        return this.modelMapper.map(rateEntity, RateServiceModel.class);
    }


    private double calculateRatingOverall(double sum, int count, double oldValue, double newValue) {
        return (sum - oldValue + newValue) / count;
    }
}
