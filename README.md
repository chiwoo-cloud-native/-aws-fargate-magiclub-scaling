# aws-fargate-magiclub-scaling

ECS Fargate 서비스를 대상으로 Scaling Policy 정책을 적용 합니다.  
이를 통해 AWS 가 강조하는 사용자 요청 부하에 대응하는 탄력적인 확장을 경험 합니다.

## Requirements

사전에 운영 중인 AWS Fargate 서비스가 있어야 Scaling-Policy 정책을 구성 할 수 있습니다.   
AWS Fargate 서비스 배포는 [Automation Building AWS Fargate & Deploy application](https://symplesims.github.io/devops/aws%20fargate/terraform/2022/04/23/building-aws-fargate.html) 블로그를 참고 하세요.  

| Name      | Version     |
|-----------|-------------|
| terraform | >= 1.0.0    |
| aws       | >= 3.75.1   |

## Providers

| Name               | Version   |
|--------------------|-----------|
| hashicorp/aws      | >= 4.10.0 |

## Modules

| Name                    |  Type   | Description                                                |
|-------------------------|:-------:|:-----------------------------------------------------------|
| modules/target-tracking | Local   | Terraform module for Target-Tracking scaling policy on ECS |

## Inputs

<table>
<thead>
<tr>
  <th>Name</th>
  <th>Description</th>
  <th>Type</th>
  <th>Required</th>
  <th>Default</th>
</tr>
</thead>
<tbody>

<tr>
  <td>project</td>
  <td>프로젝트 코드 입니다. 약어로 8자 이내로 입력하세요 </td>
  <td>string</td>
  <td>Y</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>region</td>
  <td>AWS Region 코드 입니다. ap-northeast-2 인 경우 an2 입니다.</td>
  <td>string</td>
  <td>Y</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>environment</td>
  <td>Production / Development 와 같은 운영 환경 입니다.</td>
  <td>string</td>
  <td>Y</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>env</td>
  <td>environment 값의 별칭으로 첫번째 알파벳의 소문자 입니다.</td>
  <td>string</td>
  <td>Y</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>domain</td>
  <td>AWS Certificate 인증서가 등록된 도메인 입니다.</td>
  <td>string</td>
  <td>Y</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>owner</td>
  <td>AWS 클라우드 서비스 및 리소스 관리 주체(Owner) 입니다.</td>
  <td>string</td>
  <td>Y</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>team</td>
  <td>AWS 클라우드 서비스 및 리소스 관리 팀(Team) 입니다. </td>
  <td>string</td>
  <td>Y</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>container_name</td>
  <td>ECS 서비스(애플리케이션) 이름 입니다. </td>
  <td>string</td>
  <td>Y</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>max_capacity</td>
  <td>Scaling 조정 정책의 최소로 줄이는 크기 입니다. </td>
  <td>number</td>
  <td>Y</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>max_capacity</td>
  <td>Scaling 조정 정책의 최대로 늘리는 크기 입니다. </td>
  <td>number</td>
  <td>Y</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>metric</td>
  <td>조정 정책을 컨트롤 하는 매트릭 지표를 설정 합니다. cpu, mem, alb 중 하나를 선택 할 수 있습니다.</td>
  <td>string</td>
  <td>N</td>
  <td>"cpu"</td>
</tr>
<tr>
  <td>target_value</td>
  <td>매트릭 지표의 임계 값을 설정 합니다.</td>
  <td>number</td>
  <td>Y</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>scale_in_cooldown</td>
  <td>Scale-In 조정 정책의 휴지 시간을 설정 합니다. (Unit: Seconds)</td>
  <td>number</td>
  <td>N</td>
  <td>300</td>
</tr>
<tr>
  <td>scale_out_cooldown</td>
  <td>Scale-Out 조정 정책의 휴지 시간을 설정 합니다. (Unit: Seconds)</td>
  <td>number</td>
  <td>N</td>
  <td>300</td>
</tr>
<tr>
  <td>disable_scale_in</td>
  <td>Scale-In 조정 작업의 비 활성화 여부를 설정 합니다.</td>
  <td>bool</td>
  <td>N</td>
  <td>false</td>
</tr>
</tbody>
</table>


## Git

aws-fargate-magiclub-scaling 테라폼 프로젝트를 `git clone` 명령으로 내려 받습니다.

```
git clone https://github.com/chiwoo-cloud-native/aws-fargate-magiclub-scaling.git
```

## Build

프로젝트 기준 경로 `aws-fargate-magiclub-scaling` 로 이동하여 `terraform apply` 명령을 통해 ECS 서비스를 대상으로 Target-Tracking 조정 정책을 적용 합니다. 

```
cd aws-fargate-magiclub-scaling

terraform init && terraform apply -auto-approve
```

## Destroy
`terraform destroy` 명령을 실행하여 Target-Tracking 조정 정책을 한번에 제거 합니다. 
```
terraform destroy -auto-approve
```
