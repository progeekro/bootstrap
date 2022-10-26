 .. Copyright (C) 2021-2022 Zaharia Constantin <constantin.zaharia@progeek.ro>
 .. Copyright (C) 2021-2022 ProGeek <https://progeek.ro>
 .. SPDX-License-Identifier: GPL-3.0-or-later

Description
===========

Link-Layer Discovery Protocol is an industry standard protocol which enables
network devices to exchange information about themselves with their neighbors
connected over network links. This in turn can be used to locate other devices
connected to a particular device and port.

The `lldpd`__ Debian package provides a lightweight :command:`lldpd` daemon
which implements this protocol and can be installed on Debian/Ubuntu based
hosts to advertise the LLDP notifications to other devices. This might be
useful in more complex environments with multiple layers of infrastructure
comprised of physical hosts, virtual machines and containers.

The ``progeekro.lldpd`` role can be used to install and manage the
:command:`lldpd` service and by default will try to distinguish virtualized
hosts (VMs, containers) from physical ones to make their management easier by
changing their "ChassisID" attribute to reflect their virtualized status.

.. __: https://packages.debian.org/stable/lldpd