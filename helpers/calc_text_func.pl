
use 5.010;

$hlp='helpers/calc_text_func.xsl';    #extract section
$hlp0='helpers/calc_text_func0.xsl';  #replace section

$source= 'source/text/scalc/01/04060110.xhp';
$tmp = $source . '.tmp';

@todo = qw/ CHAR CLEAN CODE CONCATENATE DECIMAL DOLLAR EXACT FIND FIXED LEFT LEFTB LEN LENB LOWER MID MIDB PROPER REPLACE REPT RIGHT RIGHTB SEARCH SUBSTITUTE T TEXT TRIM UNICHAR UNICODE UPPER /;


for $F ( @ARGV) {
  $f=lc $F;
  say $F

  system qq( xsltproc --stringparam func $F  $hlp  $source > source/text/scalc/01/func_$f.xhp );

  system qq( xsltproc --stringparam func $f  $hlp0 $source > $tmp );
  rename $tmp, $source;

  $mk .= qq(    helpcontent2/source/text/scalc/01/func_$f \\\n);
}

say qq(TODO. add to git and  AllLangHelp_scalc.mk :
$mk);
