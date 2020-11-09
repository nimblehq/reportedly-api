[![Build Status](CI_BADGE_URL goes here)](REPO_URL goes here)

## Introduction

> TBD

## Project Setup



### Development

* Setup the databases:

    * Postgres:

    ```sh
    rake db:setup
    ```




### Test

* Run all tests:

```sh
docker-compose -f docker-compose.test.yml run test
```

* Run a specific test:

```sh
docker-compose -f docker-compose.test.yml run test bin/bundle exec spec [rspec-params]
```

### Automated Code Review Setup
- Add a bot (i.e. `team-nimblehq`) to this repository or to the organization. The bot requires permission level “Write” to be able to set a PR’s status.

- Create a [Personal Access Token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)
from bot account with `public_repo` scope, and set it as `DANGER_GITHUB_API_TOKEN` secret on Semaphore Environment Settings.

## License

This project is Copyright (c) 2014-2020 Nimble. It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
