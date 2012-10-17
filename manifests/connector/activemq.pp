# == Define: mcollective::connector::activemq
#
#
# == Parameters
#
# [*name*]
#   The path to the mcollective configuration
# [*pool*]
#   The ActiveMQ pool information
#
# == Example:
#
#   mcollective::connector::activemq { '/etc/mcollective/server.cfg':
#     pool       => [
#       {
#         host     => 'activemq.host',
#         port     => 61614,
#         user     => 'activemq.user',
#         password => 'hunter2',
#         ssl      => {
#           ca     => '/path/to/ca/cert',
#           key    => '/path/to/pem/rsa/private/key',
#           cert   => '/path/to/pem/certificate',
#        },
#        {
#          # Additional activemq pool entries
#        }
#     ],
#   }
define mcollective::connector::activemq($pool) {

  mcollective::plugin { 'connector/activemq': }
  concat::fragment { "${name} - activemq connector":
    content => template('mcollective/connector/activemq.cfg.erb'),
    order   => 20,
    target  => $name,
  }
}
