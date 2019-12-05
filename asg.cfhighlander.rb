CfhighlanderTemplate do

  DependsOn 'vpc@1.5.0'

  Name 'asg'

  Parameters do
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', isGlobal: true
    ComponentParam 'NetworkPrefix', isGlobal: true
    ComponentParam 'StackOctet', isGlobal: true
    ComponentParam 'VPCId', type: 'AWS::EC2::VPC::Id'
    ComponentParam 'Ami', type: 'AWS::EC2::Image::Id'
    ComponentParam 'InstanceType'
    ComponentParam 'KeyName'
    ComponentParam 'MinSize'
    ComponentParam 'MaxSize'
    ComponentParam 'SpotPrice', ''
    ComponentParam 'HealthCheckType', 'EC2', allowedValues: ['EC2','ELB']
    
    maximum_availability_zones.times do |az|
      ComponentParam "SubnetCompute#{az}"
    end
    security_groups.each do |name, sg|
      ComponentParam name, type: 'AWS::EC2::SecurityGroup::Id'
    end if defined? security_groups

    if defined?(ecs_autoscale)
      ComponentParam 'EnableScaling', 'false', allowedValues: ['true','false']
    end

    loadbalancers.each do |lb|
      ComponentParam lb
    end if defined? loadbalancers

    targetgroups.each do |tg|
      ComponentParam tg
    end if defined? targetgroups

  end

end
