package com.ste4o26.cookviser_rest_api.services;

import com.ste4o26.cookviser_rest_api.domain.entities.CuisineEntity;
import com.ste4o26.cookviser_rest_api.domain.service_models.CuisineServiceModel;
import com.ste4o26.cookviser_rest_api.exceptions.CuisineDontExistsException;
import com.ste4o26.cookviser_rest_api.repositories.CuisineRepository;
import com.ste4o26.cookviser_rest_api.services.interfaces.CuisineService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

import static com.ste4o26.cookviser_rest_api.init.ErrorMessages.*;

@Service
public class CuisineServiceImpl implements CuisineService {
    private final CuisineRepository cuisineRepository;
    private final ModelMapper modelMapper;

    @Autowired
    public CuisineServiceImpl(CuisineRepository cuisineRepository, ModelMapper modelMapper) {
        this.cuisineRepository = cuisineRepository;
        this.modelMapper = modelMapper;
    }

    @Override
    public List<CuisineServiceModel> fetchAll() {
        List<CuisineEntity> allCuisines = this.cuisineRepository.findAll();

        return allCuisines.stream()
                .map(cuisineEntity -> this.modelMapper.map(cuisineEntity, CuisineServiceModel.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<CuisineServiceModel> fetchFirstFourMostPopulated() {
        List<CuisineEntity> firstFourMostPopulated =
                this.cuisineRepository.findFirstFourMostPopulated(PageRequest.of(0, 4));

        return firstFourMostPopulated.stream()
                .map(cuisineEntity -> this.modelMapper.map(cuisineEntity, CuisineServiceModel.class))
                .collect(Collectors.toList());
    }

    @Override
    public CuisineServiceModel fetchByName(String name) throws CuisineDontExistsException {
        if (name == null || name.trim().isEmpty()) {
            throw new CuisineDontExistsException(CUISINE_NOT_FOUND);
        }

        CuisineEntity cuisineEntity = this.cuisineRepository.findByNameIgnoreCase(name)
                .orElseThrow(() -> new CuisineDontExistsException(CUISINE_NOT_FOUND));

        return this.modelMapper.map(cuisineEntity, CuisineServiceModel.class);
    }

    @Override
    public CuisineServiceModel persist(CuisineServiceModel cuisineServiceModel) {
        CuisineEntity cuisineEntity = this.modelMapper.map(cuisineServiceModel, CuisineEntity.class);
        cuisineEntity.setRecipes(new HashSet<>());
        CuisineEntity created = this.cuisineRepository.saveAndFlush(cuisineEntity);
        return this.modelMapper.map(created, CuisineServiceModel.class);
    }
}
