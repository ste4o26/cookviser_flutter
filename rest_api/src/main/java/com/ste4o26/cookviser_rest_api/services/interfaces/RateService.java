package com.ste4o26.cookviser_rest_api.services.interfaces;

import com.ste4o26.cookviser_rest_api.domain.service_models.RateServiceModel;

import java.util.List;

public interface RateService {

    List<RateServiceModel> fetchAll();

    RateServiceModel rate(RateServiceModel rateServiceModel);
}
