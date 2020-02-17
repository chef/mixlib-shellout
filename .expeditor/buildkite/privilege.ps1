echo "Import-Module "$PWD\.expeditor\buildkite\UserRights.psm1""
Import-Module "$PWD\.expeditor\buildkite\UserRights.psm1"
Grant-UserRight -Account "ContainerAdministrator" -Right SeIncreaseQuotaPrivilege
Grant-UserRight -Account "ContainerAdministrator" -Right SeAssignPrimaryTokenPrivilege
get-process
$procid=get-process lsass |select -expand id
kill $procid
