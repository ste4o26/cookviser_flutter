package com.ste4o26.cookviser_rest_api.web.controllers;

import com.ste4o26.cookviser_rest_api.domain.binding_models.UserBindingModel;
import com.ste4o26.cookviser_rest_api.domain.entities.enums.RoleName;
import com.ste4o26.cookviser_rest_api.domain.response_models.UserResponseModel;
import com.ste4o26.cookviser_rest_api.domain.service_models.UserServiceModel;
import com.ste4o26.cookviser_rest_api.exceptions.*;
import com.ste4o26.cookviser_rest_api.init.ErrorMessages;
import com.ste4o26.cookviser_rest_api.services.interfaces.CloudService;
import com.ste4o26.cookviser_rest_api.services.interfaces.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.management.relation.RoleNotFoundException;
import java.util.List;
import java.util.stream.Collectors;

import static com.ste4o26.cookviser_rest_api.domain.entities.enums.RoleName.*;
import static com.ste4o26.cookviser_rest_api.init.ErrorMessages.IMAGE_NOT_PRESENT;
import static com.ste4o26.cookviser_rest_api.init.ErrorMessages.USERNAME_NOT_EXISTS;
import static org.springframework.http.HttpStatus.*;

@CrossOrigin(exposedHeaders = {"jwtToken"})
@RestController
@RequestMapping("/user")
public class UserController {
    private final UserService userService;
    private final ModelMapper modelMapper;
    private final CloudService cloudService;

    @Autowired
    public UserController(UserService userService, ModelMapper modelMapper, CloudService cloudService) {
        this.userService = userService;
        this.modelMapper = modelMapper;
        this.cloudService = cloudService;
    }

    @Operation(summary = "Get top 3 chefs", description = "Get top 3 chefs")
    @GetMapping("/best-three")
    public ResponseEntity<List<UserResponseModel>> getBestThree() {
        List<UserServiceModel> bestThreeChefs = this.userService.fetchBestThreeChefs();

        List<UserResponseModel> collect = bestThreeChefs.stream()
                .map(userServiceModel -> this.modelMapper.map(userServiceModel, UserResponseModel.class))
                .collect(Collectors.toList());

        return new ResponseEntity<>(collect, OK);
    }

    @Operation(summary = "Get user by username", description = "Get user by username")
    @SecurityRequirement(name = "Bearer Authentication")
    @GetMapping("/by-username")
    public ResponseEntity<UserResponseModel> getByUsername(@RequestParam("username") String username) {
        if (username == null || username.trim().isEmpty()) {
            throw new UsernameNotFoundException("Username is required!");
        }

        UserServiceModel userServiceModel = this.userService.fetchByUsername(username);

        UserResponseModel userResponseModel = this.modelMapper.map(userServiceModel, UserResponseModel.class);
        return new ResponseEntity<>(userResponseModel, OK);
    }

    @Operation(summary = "Get all users", description = "Get all users")
    @SecurityRequirement(name = "Bearer Authentication")
    @PreAuthorize("hasAnyAuthority('UPDATE', 'DELETE')")
    @GetMapping("all")
    public ResponseEntity<List<UserResponseModel>> getAll(Authentication authentication) {
        List<UserServiceModel> allUsers = this.userService.fetchAll();

        List<UserResponseModel> collect = allUsers.stream()
                .map(userServiceModel -> this.modelMapper.map(userServiceModel, UserResponseModel.class))
                .collect(Collectors.toList());

        return new ResponseEntity<>(collect, OK);
    }

    @Operation(summary = "Upload profile picture", description = "Upload profile picture")
    @SecurityRequirement(name = "Bearer Authentication")
    @PutMapping("/update-profile-image")
    public ResponseEntity<UserResponseModel> putUpdateUserProfileImage(
            @RequestPart("profileImage") MultipartFile profileImage,
            @RequestParam("username") String username) throws ImageNotUploadedException, ImageNotPresentException {
        if (profileImage == null || profileImage.isEmpty()) {
            throw new ImageNotPresentException(IMAGE_NOT_PRESENT);
        }

        String imageUrl = this.cloudService.uploadImage(profileImage);

        UserServiceModel userServiceModel = this.userService.fetchByUsername(username);
        userServiceModel.setProfileImageUrl(imageUrl);

        UserServiceModel updatedUser = this.userService.update(userServiceModel);
        UserResponseModel responseModel = this.modelMapper.map(updatedUser, UserResponseModel.class);

        return new ResponseEntity<>(responseModel, OK);
    }

    @Operation(summary = "Update user profile", description = "Update user profile")
    @SecurityRequirement(name = "Bearer Authentication")
    @PutMapping("/update-profile")
    public ResponseEntity<UserResponseModel> putUpdateUserProfile(
            Authentication authentication,
            @RequestBody UserBindingModel userBindingModel,
            @RequestParam("editorUsername") String editorUsername) throws UserNotAuthorizedException {
        UserServiceModel editor = this.userService.fetchByUsername(editorUsername);
        RoleName editorsRole = editor.getRole().getRole();

        if (!editorUsername.equals(userBindingModel.getUsername()) &&
                !(editorsRole.equals(ROLE_MODERATOR) || editorsRole.equals(ROLE_ADMIN))) {
            throw new UserNotAuthorizedException(ErrorMessages.ACCESS_DENIED_MESSAGE);
        }

        UserServiceModel userServiceModel = this.userService.fetchByUsername(userBindingModel.getUsername());
        userServiceModel.setUsername(userBindingModel.getUsername());
        userServiceModel.setEmail(userBindingModel.getEmail());
        userServiceModel.setDescription(userBindingModel.getDescription());

        UserServiceModel updatedUser = this.userService.update(userServiceModel);
        UserResponseModel responseModel = this.modelMapper.map(updatedUser, UserResponseModel.class);

        return new ResponseEntity<>(responseModel, OK);
    }


    @Operation(summary = "Promote user", description = "Promote user")
    @SecurityRequirement(name = "Bearer Authentication")
    @PreAuthorize("hasAnyAuthority('UPDATE', 'DELETE')")
    @PutMapping("/promote")
    public ResponseEntity<UserResponseModel> putPromote(Authentication authentication, @RequestBody String username)
            throws UsernameNotFoundException, RoleNotFoundException, PromotionDeniedException {
        if (username == null || username.trim().isEmpty()) {
            throw new UsernameNotFoundException(String.format(USERNAME_NOT_EXISTS, username));
        }

        UserServiceModel userServiceModel = this.userService.fetchByUsername(username);
        UserServiceModel promotedUser = this.userService.promote(userServiceModel);

        UserResponseModel responseModel = this.modelMapper.map(promotedUser, UserResponseModel.class);
        return new ResponseEntity<>(responseModel, OK);
    }

    @Operation(summary = "Demote user", description = "Demote user")
    @SecurityRequirement(name = "Bearer Authentication")
    @PreAuthorize("hasAnyAuthority('UPDATE', 'DELETE')")
    @PutMapping("/demote")
    public ResponseEntity<UserResponseModel> putDemote(Authentication authentication, @RequestBody String username)
            throws UsernameNotFoundException, RoleNotFoundException, DemotionDeniedException {
        if (username == null || username.trim().isEmpty()) {
            throw new UsernameNotFoundException(String.format(USERNAME_NOT_EXISTS, username));
        }

        UserServiceModel userServiceModel = this.userService.fetchByUsername(username);
        UserServiceModel promotedUser = this.userService.demote(userServiceModel);

        UserResponseModel responseModel = this.modelMapper.map(promotedUser, UserResponseModel.class);
        return new ResponseEntity<>(responseModel, OK);
    }
}
