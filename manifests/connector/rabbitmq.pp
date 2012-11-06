# == Define: mcollective::connector::rabbitmq
#
#
# == Parameters
#
# [*name*]
#   The path to the mcollective configuration
# [*pool*]
#   The RabbitMQ pool information
#
# == Example:
#
#   mcollective::connector::rabbitmq { '/etc/mcollective/server.cfg':
#     pool       => [
#       {
#         host     => 'rabbitmq.host',
#         port     => 61614,
#         user     => 'rabbitmq.user',
#         password => 'hunter2',
#         ssl      => {
#           ca     => '/path/to/ca/cert',
#           key    => '/path/to/pem/rsa/private/key',
#           cert   => '/path/to/pem/certificate',
#        },
#        {
#          # Additional rabbitmq pool entries
#        }
#     ],
#   }
define mcollective::connector::rabbitmq($pool) {

  concat::fragment { "${name} - rabbitmq connector":
    content => template('mcollective/connector/rabbitmq.cfg.erb'),
    order   => 20,
    target  => $name,
    require => Class['mcollective::server'],
  }
}
