package bigbro::Schema::Result::Devices;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/Validation::DBStruct/);

__PACKAGE__->table('devices');
__PACKAGE__->add_columns(
   'id' => {
      data_type => 'integer',
      is_auto_increment => 1,
   },
   'mac_address' => {
      data_type => 'varchar',
      size => '255',
   },
   'hostname' => {
      data_type => 'varchar',
      size => '255',
      is_nullable => 1,
   },
); 

__PACKAGE__->set_primary_key('id');

# Relationships go here

1;
