	::Script to assign LAN and Radmin VPN IPs + GW + DNS to the bridge.
	::If you need to change IPs, just change them in variables (in the set section)


	::Disable unneeded output
	@echo off

	::Set section


	::Interface name. By default the name is "Network Bridge".
	set INTERFACE_NAME=Network Bridge

	::Change IPs if desired.
	::LAN IP
	set LAN_IP_ADDRESS=192.168.1.2
	set LAN_SUBNET_MASK=255.255.255.0

	::Radmin IP
	set RV_IP_ADDRESS=26.0.0.3
	set RV_SUBNET_MASK=255.0.0.0

	::Default gateway IP
	set DEFAULT_GATEWAY=192.168.1.1

	::DNS servers. OpenDNS and local router.
	set DNS_ADRESS1=208.67.220.220
	set DNS_ADRESS2=192.168.1.1


	::End of set section


	::Start of assigning section

	::Add local IP to the bridge.
	netsh interface ipv4 add address "%INTERFACE_NAME%" %LAN_IP_ADDRESS% %LAN_SUBNET_MASK%

	::Add Radmin VPN IP to the bridge.
	netsh interface ipv4 add address "%INTERFACE_NAME%" %RV_IP_ADDRESS% %RV_SUBNET_MASK%

	::Add default gateway to the bridge.
	netsh interface ipv4 add route 0.0.0.0/0 "%INTERFACE_NAME%" %DEFAULT_GATEWAY%

	::Add DNS server#1. OpenDNS in such case.
	netsh interface ipv4 add dnsservers "Network Bridge" address=%DNS_ADRESS1%

	::Add DNS server#2. Local router in such case.
	netsh interface ipv4 add dnsservers "Network Bridge" address=%DNS_ADRESS2%

	::End of assigning section


	::Press any key to continue.
	pause