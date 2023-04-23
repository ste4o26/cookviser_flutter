const String DOMAIN_URL = 'http://localhost:8080';
const double customCardSize = 350;

enum Routes {
  home('/'),
  profile('/profile'),
  cuisines('/cuisines'),
  recipes('/all_recipes'),
  cuisineRecipes('/recipes_by_cuisine'),
  signIn('/sign_in'),
  signUp('/sign_up');

  const Routes(this.name);
  final String name;
}

enum Headers {
  contentType(
      <String, String>{'Content-Type': 'application/json; charset=UTF-8'}),
  authorization(<String, String>{'Authorization': 'Bearer '});

  const Headers(this.header);
  final Map<String, String> header;
}

enum RecipeEndpoints {
  all('$DOMAIN_URL/recipe/all'),
  nextPage('$DOMAIN_URL/recipe/next-recipes'),
  nextPageByCuisine('$DOMAIN_URL/recipe/next-by-cuisine'),
  bestFour('$DOMAIN_URL/recipe/best-four'),
  rate('$DOMAIN_URL/recipe/rate');

  const RecipeEndpoints(this.endpoint);
  final String endpoint;
}

enum CuisineEndpoints {
  all('$DOMAIN_URL/cuisine/all'),
  mostPopulated('$DOMAIN_URL/cuisine/first-four-most-populated');

  const CuisineEndpoints(this.endpoint);
  final String endpoint;
}

enum AuthEndpoints {
  login('$DOMAIN_URL/auth/login'),
  register('$DOMAIN_URL/auth/register');

  const AuthEndpoints(this.endpoint);
  final String endpoint;
}

enum UserEndpoints {
  betsThree('$DOMAIN_URL/user/best-three'),
  byUsername('$DOMAIN_URL/user/by-username');

  const UserEndpoints(this.endpoint);
  final String endpoint;
}
