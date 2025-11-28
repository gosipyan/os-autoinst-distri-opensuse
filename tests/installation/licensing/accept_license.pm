# Copyright 2021 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

# Summary: Test module to accept license agreement and proceed to the next
#          installer page.

# Maintainer: QE Installation and Migration (QE Iam) <none@suse.de>

use Mojo::Base 'y2_installbase';
use testapi;

sub run {

    save_screenshot;
    record_info 'accept license';
    sleep 10;
    send_key("alt-y");
    sleep 10;
    send_key("alt-y");
    save_screenshot;

    $testapi::distri->get_license_agreement()->accept_license();
}

1;
