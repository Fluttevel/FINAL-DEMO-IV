# Telegram Bot "Crisp Cinema" for movies search
## Developing by Python
## Deploying by AWS, Terraform, Terragrunt, Docker

:wave:Hello and Welcome,

### Our branches:

:round_pushpin:**Telelgram_Bot_v.1.0** — the simplest Telegram Bot for choosing movies in random order.
Check it [here](https://t.me/crisp_cinema_bot).

---

Hello, this project create and deploy 
infrastructure on AWS

### Before running commands:

> You need to open file `providers/dev/terragrunt.hcl` and change 
variables values:
> - `ecr_repo_url`
> - `aws_region` *[Optional]*
>
> Replace current **ID** to **your AWS account ID** and optionality replace **AWS region**

> Also you need change `root` directory 
> on './providers./dev/' using command:
> ```md
> cd .\providers\dev\ # for Windows
> ```
> ```md
> cd ./providers/dev/ # for Linux
> ```

> Finally, being in the right directory 
> execute command:
> ```md
> terragrunt run-all init
> ```

### Main Terragrunt commands:

```md
terragrunt run-all plan
``` 

```md
terragrunt run-all apply
```

```md
terragrunt run-all destroy
```