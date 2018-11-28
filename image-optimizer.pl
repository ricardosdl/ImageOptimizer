#!perl
use strict;
use warnings;
use 5.010;
use GD;
use File::Spec;
use File::Basename;

my $dir = shift or die "Usage: $0 DIRNAME\n";

opendir my $dh, $dir  or die "Cannot open directory: $!";
my @files = readdir $dh;
close $dh;

foreach(@files) {
    my $path = File::Spec->catfile($dir, $_);
    if (-f $path) {
        my $origin_image = GD::Image->new($path);
        my $optimized_jpeg = $origin_image->jpeg(70);
        
        my ($file_name, $file_dir, $file_extension) = fileparse($path, qr/\.[^.]*/);
        
        
        my $output_file_path = File::Spec->catfile($dir, $file_name . '-optimized.jpg');
        open(my $out, '>:raw', $output_file_path) or die "Error: $!";
        print $out $optimized_jpeg;
        close($out);
        
    }
}