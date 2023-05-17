package com.ste4o26.cookviser_rest_api.repositories;

import com.ste4o26.cookviser_rest_api.domain.entities.CuisineEntity;
import com.ste4o26.cookviser_rest_api.domain.entities.RecipeEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecipeRepository extends JpaRepository<RecipeEntity, String> {
    List<RecipeEntity> findAllByNameContaining(String searchValue);

    List<RecipeEntity> findAllByCuisine(CuisineEntity cuisine, Pageable pageable);

    @Query(value = "SELECT * FROM recipes r ORDER BY r.rating_overall DESC LIMIT 4",nativeQuery = true)
    List<RecipeEntity> fetchBestFour();
}
