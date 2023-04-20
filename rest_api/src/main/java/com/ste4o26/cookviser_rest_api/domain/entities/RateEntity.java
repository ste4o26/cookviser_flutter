package com.ste4o26.cookviser_rest_api.domain.entities;

import lombok.*;

import javax.persistence.*;

@Data
@Entity(name = "rates")
@Table(name = "rates")
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class RateEntity extends BaseEntity {
    @Column(name = "rate_value")
    private int rateValue;

    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    @ManyToOne(targetEntity = UserEntity.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private UserEntity user;

    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    @ManyToOne(targetEntity = RecipeEntity.class, fetch = FetchType.EAGER)
    @JoinColumn(name = "recipe_id", referencedColumnName = "id")
    private RecipeEntity recipe;
}
