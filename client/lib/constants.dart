const String DOMAIN_URL = 'http://localhost:8080';
const double CUSTOM_CARD_SIZE = 350;

enum Routes {
  root("/"),
  home('/home'),
  profile('/profile'),
  cuisines('/cuisines'),
  recipes('/recipes'),
  signIn('/sign_in'),
  signUp('/sign_up'),
  allUsers('/all_users');
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
  byUsername('$DOMAIN_URL/user/by-username'),
  allUsers('$DOMAIN_URL/user/all'),
  promote('$DOMAIN_URL/user/promote'),
  demote('$DOMAIN_URL/user/demote');

  const UserEndpoints(this.endpoint);
  final String endpoint;
}
