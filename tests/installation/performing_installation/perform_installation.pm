# SUSE's openQA tests
#
# Copyright 2021 SUSE LLC
# SPDX-License-Identifier: FSFAP

# Summary: Wait for the installation to be finished successfully.
# Use TIMEOUT_SCALE so expected installation time can be adjusted
# for slower architectures.
# Maintainer: QE Installation and Migration (QE Iam) <none@suse.de>

use Mojo::Base 'y2_installbase';
use testapi 'get_var';
use Test::Assert ':all';
use Mojo::Base 'y2_installbase';
use testapi;
use lockapi;
use mmapi;
use utils;
use Utils::Architectures;
use Utils::Backends;
use version_utils qw(:VERSION :BACKEND is_sle is_leap is_sle_micro);
use ipmi_backend_utils;

sub run {

    wait_still_screen 10;
    record_info('Step 1', 'intergrity check tab');
    foreach (1 .. 3) {
       save_screenshot;
       wait_screen_change { send_key "alt-i"; };
    }
    wait_still_screen 10;
    record_info('Step 2', 'intergrity check tab');
    foreach (1 .. 6) {
       save_screenshot;
       wait_screen_change { send_key "alt-i"; };
    }
    wait_still_screen 10;
    record_info('Step 3', 'intergrity check tab');
    foreach (1 .. 4) {
       save_screenshot;
       wait_screen_change { send_key "alt-i"; };
    }
    wait_still_screen 10;
    record_info('Step 4', 'intergrity check tab');
    foreach (1 .. 20) {
       save_screenshot;
       wait_screen_change { send_key "alt-i"; };
       wait_still_screen 5;
    }
    wait_still_screen 10;

    my $performing_install = $testapi::distri->get_performing_installation();

    #$performing_install->get_performing_installation_page();

    $performing_install->wait_for_installation_popup({
            timeout => 2400,
            timeout_scale => get_var('TIMEOUT_SCALE', 1),
            interval => 2,
            message => 'System reboot popup did not appear'});

    assert_matches(qr/The system will reboot now/,
        $performing_install->get_system_reboot_popup()->text(),
        'System reboot popup is not displayed');
}

1;
