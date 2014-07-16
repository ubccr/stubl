#!/usr/bin/perl

@s=();
$l=0;
while(<>){
  chomp;
  @c=split(/(?=\s+)/);
  if(scalar(@s) && ($l % 32)){
    print(join("",map {$s[$_]eq$c[$_] ? " " x (length($c[$_])-1) . q(") . ($c[$_]=~/\n/ ? "\n":"") : $c[$_]} (0..$#c)),"\n")
  }
  else{
    print(join("",@c),"\n")
  }
  @s=@c;
  $l++
}

