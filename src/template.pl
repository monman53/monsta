#!/usr/bin/perl

# filenames
my $adoc = $ARGV[0];
my $html = $ARGV[1];

# source file timestamp
my $epoch = `stat -c %Y $adoc`;
chomp($epoch);
my $timestamp = `date -u -d \@$epoch +'%F %T'`;

# get title
open(FH, "< $adoc");
my $title = <FH>;
close(FH);


#----------------
# header
#----------------

print "<!doctype html>";
print "<meta name='viewport' content='width=device-width, initial-scale=1'>";
print "<meta charset='utf-8'>";
print "<link rel='stylesheet' href='/css/main.css'>";
# print "<link rel='stylesheet' href='/css/asciidoc.css'>";

# title
print "<title>$title</title>";
print "<h1>$title</h1>";
print "<a href='/'>[Top]</a>";
# print "<a href='https://powerman.name/doc/asciidoc'>[asciidoc cheat sheet]</a>";
print "<hr>";
print "<h3>Table of Contents</h3>";
print "<div id='toc'></div>";
print "<div id='content'>";


#----------------
# contents
#----------------

system("cat $html");


#----------------
# footer
#----------------

print "</div>";
print "<h2>脚注</h2>";
print "<div id='footnotes'></div>";
print "<hr>";
print "<p>last update $timestamp (UTC)</p>";
print "<p>this page is generated by <a href='https://github.com/monman53/monsta'>monsta</a></p>";

# scripts
print "<script src='/js/asciidoc.js'></script>";
print "<script>asciidoc.install(1);</script>";
print "<script src='/js/LaTeXMathML.js'></script>";
print "<script src='/js/ASCIIMathML.js'></script>";
