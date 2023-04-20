package com.ste4o26.cookviser_rest_api.domain.entities;

import com.ste4o26.cookviser_rest_api.domain.entities.enums.AuthorityName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@EqualsAndHashCode(callSuper = true)
@Entity(name = "authorities")
@Table(name = "authorities")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserAuthorityEntity extends BaseEntity {
    @Column(name = "authority", nullable = false)
    @Enumerated(EnumType.STRING)
    private AuthorityName authority;
}
