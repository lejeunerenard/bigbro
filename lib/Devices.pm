package Devicess;
use Dancer ':syntax';
use Dancer::Plugin::DBIC;
use HTML::FillInForm;
use Data::Dumper;
use Validate::Validate;
use Stagehand::Stagehand;

# Setup Models' 'aliases'
sub Devices { model('Devices'); }


prefix '/devicess' => sub {

my %tmpl_params;
hook 'before' => sub {
   # Clear tmpl Params;
   %tmpl_params = ();
};

# ==== CRUD =====

# Read
get '/?:id?' => sub {
   if ( param 'id' ) {
      $tmpl_params{devices} = Devices->find(param 'id');   # \@{[ ]} will force a list context
      template 'devices/devices_read', \%tmpl_params;
   } else {
      $tmpl_params{devicess} = \@{[Devices->all]};   # \@{[ ]} will force a list context
      template 'devices/devices_list', \%tmpl_params;
   }
};

# Create
post '/?:id?' => sub {
   set serializer => 'JSON';

   my %params = params;
   my $success;

   my $result = Devices->create( \%params );
   if ($result->{errors}) {
      return $result;
   }
   $success = "devices added Successfully";
   return { success => [ { success => $success } ] };
};

# Update
put '/?:id?' => sub {
   return put_cntrl();
};
post '/put/?:id?' => sub {
   return put_cntrl();
};
sub put_cntrl {
   set serializer => 'JSON';

   my %params = params;
   my $success;

   my $result = Devices->find(param 'id')->update( \%params );
   if ($result->{errors}) {
      return $result;
   }
   $success = "devices updated Successfully";
   return { success => [ { success => $success } ] };
}

# Delete
get '/delete/:id' => sub {
   Devices->find(param 'id')->delete();
   redirect '/devicess/';
};
del '/:id' => sub {
   Devices->find(param 'id')->delete();
   redirect '/devicess/';
};

# ---- Views -----

get '/add/?' => sub {
	template 'devices/devices_edit', \%tmpl_params;
};

get '/edit/:id' => sub {
   if (param 'id') { $tmpl_params{devices} = Devices->find(param 'id'); }
   %tmpl_params = (%tmpl_params, %{Devices->search({ id => param 'id' }, {
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
   })->next});
	fillinform('devices/devices_edit', \%tmpl_params);
};

}; # End prefix
1;

__END__
# The original json used to create this Model:
[
   {
      "models" : [
         {
            "readable_name" : "Devices",
            "table_name" : "devices",
            "attributes" : [
               {
                  "inline" : 0,
                  "order" : "0",
                  "static_label" : 0,
                  "type" : "text",
                  "mandatory" : 1,
                  "label" : "Mac Address",
                  "max_length" : "255"
               },
               {
                  "inline" : 0,
                  "order" : "1",
                  "static_label" : 0,
                  "type" : "text",
                  "mandatory" : 0,
                  "label" : "Hostname",
                  "max_length" : "255"
               }
            ],
            "overlay" : ""
         }
      ],
      "settings" : {
         "app_name" : "bigbro",
         "module_only" : 1,
         "write_files" : 1,
         "app_path" : "/home/polok/Programming/bigbro/"
      }
   }
]
