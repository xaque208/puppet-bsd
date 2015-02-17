# Define: bsd::network::interface::bridge
#
# Handle the creation and configuration of bridge(4) interfaces.
#
define bsd::network::interface::bridge (
  $interface,
  $ensure      = 'present',
  $description = undef,
) {

  $if_name = $name
  validate_re($if_name, ['bridge'])

  validate_re(
    $ensure,
    '(up|down|present|absent)',
    '$ensure can only be one of up, down, present, or absent'
  )

  $config = {
    interface => $interface,
  }

  $bridge_ifconfig = get_hostname_if_bridge($config)

  bsd::network::interface { $if_name:
    ensure      => $ensure,
    description => $description,
    values      => [$bridge_ifconfig],
  }
}
