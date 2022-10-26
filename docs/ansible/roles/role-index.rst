 .. Copyright (C) 2021-2022 Zaharia Constantin <constantin.zaharia@progeek.ro>
 .. Copyright (C) 2021-2022 ProGeek <https://progeek.ro>
 .. SPDX-License-Identifier: GPL-3.0-or-later

.. _role_index:

Roles (by category)
===================

This is a curated index of ProGeek roles, categorized by their type and purpose.
Roles that are not linked don't have complete documentation available, or are
not yet integrated in ProGeek.

.. contents:: Role categories
   :local:

.. TODO: Each role can only be in one category.

Application environments
------------------------

Ansible roles that are designed to help with installation of various
application environments or programming languages, either via APT or other
methods.

- :ref:`progeekro.python`

Networking
----------

- :ref:`progeekro.lldpd`

System configuration
--------------------

- :ref:`progeekro.machine`
- :ref:`progeekro.mount`
- :ref:`progeekro.parted`
- :ref:`progeekro.ntp`
- :ref:`progeekro.reboot`
- :ref:`progeekro.tzdata`

Ansible internals
-----------------

These Ansible roles are used internally during playbook execution, or provide
additional functions to other roles.

- :ref:`progeekro.global_handlers`