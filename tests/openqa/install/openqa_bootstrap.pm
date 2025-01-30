# SUSE's openQA tests
#
# Copyright 2018-2019 SUSE LLC
# SPDX-License-Identifier: FSFAP

# Summary: Install openQA using openqa-bootstrap
# Maintainer: Dominik Heidler <dheidler@suse.de>

use strict;
use warnings;
use base "consoletest";
use testapi;
use utils;
use version_utils qw(has_selinux has_selinux_by_default);


sub run {
    select_console 'root-console';

    if (script_run('stat /dev/kvm') != 0) {
        record_info('No nested virt', 'No /dev/kvm found');
    }

    # allow connect to httpd_port
    #    if (has_selinux || has_selinux_by_default ) {
    assert_script_run 'setsebool -P httpd_graceful_shutdown 1';
	#}
    zypper_call('in openQA-bootstrap');
    my $proxy_var = get_var('OPENQA_WEB_PROXY') ? 'setup_web_proxy=' . get_var('OPENQA_WEB_PROXY') . ' ' : '';
    assert_script_run($proxy_var . "/usr/share/openqa/script/openqa-bootstrap", 4000);
}

sub test_flags {
    return {fatal => 1};
}

1;
