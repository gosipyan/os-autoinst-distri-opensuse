# Copyright 2021 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

# Summary: Test module to accept license agreement and proceed to the next
#          installer page.

# Maintainer: QE Installation and Migration (QE Iam) <none@suse.de>

use Mojo::Base 'y2_installbase';
use testapi;

sub run {
            wait_still_screen 10;
            mouse_set(600, 600);
            mouse_click;
            mouse_hide(1);
            send_key 'tab';
            send_key 'tab';
            send_key 'ret';
            send_key 'ret';

            wait_still_screen 10;
            mouse_set(600, 600);
            mouse_click;
            mouse_hide(1);
            send_key 'tab';
            send_key 'tab';
            send_key 'ret';
            send_key 'ret';

    $testapi::distri->get_license_agreement()->accept_license();
}

1;
