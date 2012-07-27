use File::Find;

open(LIST, '>>', './movielist.txt');
my %seen;

find(\&create_list, './');

sub create_list {

	$name = $_;
	$filename = $File::Find::name;
	@dir = split('/', $File::Find::dir);
	$curdir = $dir[$#dir];
	$tab = 0;
	foreach $dir_path (@dir){
		$tab++ if $seen{$dir_path};
	}
	
	$indent = "";
	$space = "   ";
	while($tab > 0){
		$indent = $indent.$space;
		$tab--;
	}
	
	if($filename =~ /\.avi/ || $filename =~ /\.mkv/ || $filename =~ /\.mp4/){
		
		print LIST $indent.$curdir."\n" if !defined $seen{$curdir};
		$seen{$curdir}++;
		print LIST $indent."   $name\n";
	}
	else{
		print LIST $indent.$curdir."\n" if !defined $seen{$curdir};
		$seen{$curdir}++;
	}

}

close LIST;