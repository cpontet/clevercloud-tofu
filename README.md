# Deploy on Clever Cloud with OpenTofu

## Prerequisites

* [Clever Tools (CLI)](https://www.clever-cloud.com/developers/doc/cli)
* [OpenTofu](https://opentofu.org/docs/intro/)
* [OpenTofu Clever Cloud provider](https://search.opentofu.org/provider/clevercloud/clevercloud/latest)

## Login to Clever Cloud

Login on the CLI using a web page

```sh
clever login
```
## Spring Pet Clinic

Deploy the Spring Pet Clinic app in Clever Cloud with PosgreSQL and Java War app

```sh
cd spring-petclinic
tofu init
tofu plan
tofu apply
```