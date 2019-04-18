#!/usr/bin/perl

($logfile)= @ARGV;     			# Argument, das eingegeben werden muss


# Eingabezeile ueberpruefen
			
if ($logfile eq "")
 {
   print "Aufruf: perl MST_ausw_1_neu.pl Logfile (ohne Endung) \n";	
   exit; 
 }
  

# Ausgabefiles bestimmen
     
$out = $logfile.".txt";	        	# Name des Ausgabefiles
open(OUT,">$out")     ||   die "Can't open  $out !";


# Eingabelogfile öffnen

$inlogf=$logfile.".log";
open(INPUT, "$inlogf") || die "Can't open $inlogf !";


# Kopf ins Ausgabefile schreiben

print OUT "Trial\tBed\tReak\tFB\tWahl\n";

     
while(<INPUT>)					# Kopf vom LOG-File
 {						# entfernen, bis Subject
  chop;						# erreicht, dann Abbruch
  @elem=split;			
  if($_ =~ /Subject/) {last;};
 }


 
# Solange das Logfile gelesen
	
while(<INPUT>)					# Logfile in Variablen auf-
 {				 		# splitten
  chop;
  ($Subj, $Trial, $Event, $Code, $Time, $TTime)=split;


  # Bedingung und Trialnummer vom 2.Block ermitteln
  # -----------------------------------------------

  if (($Event eq "Picture") && ($Code =~ /_T2_Picture/))
   {

    @Test  = split('_',$Code);
    $T_Nb  = @Test[0];
    $Bed   = @Test[5];

    $Trl_nr = $Trial;
    $Reaktime = 0;
    $anz_ant = 0;
    $Wahl = "---";
   }


  # Reaktionszeit merken
  # --------------------

  if  (($Event eq "Response") && ($Trl_nr == $Trial) && ($anz_ant == 0)) 
   {
    $Reaktime = $TTime / 10;
    $anz_ant = $anz_ant + 1;


    # gewaehlte Taste merken

    $Wahl_taste = $Code;

    if    ($Wahl_taste eq "1") {$Wahl = "old";}
    elsif ($Wahl_taste eq "2") {$Wahl = "sim";}
    elsif ($Wahl_taste eq "3") {$Wahl = "new";}
   }


  # FB zuordnen und Ausgabe in Datei
  # --------------------------------

  if (($Event eq "Picture") && ($Code =~ /FB_/))
   {

    @Test  = split('_',$Code);
    $FB    = @Test[1];
   
    if    ($FB eq "miss") {$FB_zahl = 0;}
    elsif ($FB eq "inco") {$FB_zahl = 1;}
    elsif ($FB eq "cor")  {$FB_zahl = 2;}


    # Ausgabe der Werte in eine Datei

    $Reak     = sprintf("%04d", $Reaktime);
    print OUT "$T_Nb\t$Bed\t$Reak\t$FB_zahl\t$Wahl\n";
    
   }

 }						# Ende Logfile einlesen


###########################################################################

# Legende:

print OUT "\n\n";
print OUT "Legende:\n";
print OUT "--------\n\n";
print OUT "FB: 0 - miss / 1 - falsch / 2 - richtig\n";


exit;


