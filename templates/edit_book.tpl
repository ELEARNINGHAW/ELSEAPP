{if $user.role_name == "staff" OR  $user.role_name == "admin" OR  $operator.mode == 'suggest' } {$restricted  = "" }  {else}  {$restricted = "disabled=\"yes\""}  {/if}
  
{if  $operator.msg == "location_id"} {$color= "red"} {$bw ="2"}
{else}                               {$color= "AAA"} {$bw ="1"}
{/if}

{if $maxElement > 0 OR $medium.doc_type_id == 99}

{$SAready    = $DOC_TYPE[ $medium.doc_type_id ][ 'SA-ready'    ] }
{$doctypetxt = $DOC_TYPE[ $medium.doc_type_id ][ 'description' ] }

{if ($medium.location_id == 0)}  {$c0 = 'checked="checked"' } {else} {$c0 = ''} {/if}
{if ($medium.location_id == 1)}  {$c1 = 'checked="checked"' } {else} {$c1 = ''} {/if}
{if ($medium.location_id == 2)}  {$c2 = 'checked="checked"' } {else} {$c2 = ''} {/if}
{if ($medium.location_id == 3)}  {$c3 = 'checked="checked"' } {else} {$c3 = ''} {/if}
{if ($medium.location_id == 4)}  {$c4 = 'checked="checked"' } {else} {$c4 = ''} {/if}
{if ($medium.location_id == 5)}  {$c5 = 'checked="checked"' } {else} {$c5 = ''} {/if}

{if $medium.doc_type_id == 99 }
  <h3 style="margin:10px; margin-bottom:0px; margin-top:0px; padding:10px; " class="bgDef bg{$collection.bib_id}">Erwerbungsvorschlag für: {$collection.title}
  {if $operator.action != 'annoteNewMedia' }  <a style="float:right;" href="{$back_URL}"><img  class="icon" style="margin-top:-4px;" title="Zurück" src="img/svg/chevron-left.svg" /></a> {/if}</h3>
    <div style="margin:10px;  padding:10px; border:solid 1px black; ">
      Wenn Sie ein Medium zur Anschaffung in der Bibliothek vorschlagen m&ouml;chten und dieses in  Ihren Semesterapparat aufgenommen werden soll, benutzen Sie bitte dieses Formular.
    </div>
    {else}
    <h5 style="margin:10px; padding:10px; color: #000"  class="bgDef bg{$collection.bib_id}" >{$collection.title}<br/> {$doctypetxt} bearbeiten
      {if $operator.action != 'annoteNewMedia' AND $operator.action != 'save' }
        <a style="float:right;" href="{$back_URL}"><img  class="icon" style="margin-top:-15px;" title="Zurück" src="img/svg/chevron-left.svg" /></a>{/if}
        <span  style="position:relative; font-size:25px; float:right; top:-18px; padding-right: 15px; " >  {$currentElement+1}/{$maxElement} </span>
    </h5>
{/if}
{/if}
<div  style="margin:10px; margin-top:0px;  padding:10px; border:solid 1px black; ">
<form  action="index.php" method="get">
<input type = "hidden" name = "dc_collection_id" value = "{$collection.dc_collection_id}" >
<input type = "hidden" name = "item"             value = "media"                          >
<input type = "hidden" name = "loc"              value = "1"                              >   {* loc ist an dieser Stelle noch nicht definiert, deshalb standard = 1 *}
<input type = "hidden" name = "action"           value = "save"                           >
<input type = "hidden" name = "document_id"      value = "{$medium.id}"                   >
<input type = "hidden" name = "doc_type_id"      value = "{$medium.doc_type_id}"          >
<input type = "hidden" name = "ppn"              value = "{$medium.ppn}"                  >
<input type = "hidden" name = "physicaldesc"     value = "{$medium.physicaldesc}"         >
<input type = "hidden" name = "sigel"            value = "{$medium.sigel}"                >
<input type = "hidden" name = "origin"           value = "{$medium.origin}"               >
<input type = "hidden" name = "shape"            value = "{$medium.shape}"                >
<input type = "hidden" name = "role"             value = "{$user.role_encode}"            >

{if $restricted}
<input type = "hidden" name = "title"            value = "{$medium.title}"        >
<input type = "hidden" name = "author"           value = "{$medium.author}"       >
<input type = "hidden" name = "ISBN"             value = "{$medium.ISBN}"         >
<input type = "hidden" name = "edition"          value = "{$medium.edition}"      >
<input type = "hidden" name = "signature"        value = "{$medium.signature}"    >
<input type = "hidden" name = "ppn"              value = "{$medium.ppn}"          >
{/if}

<table style="text-align: left; width: 100%;">
<tbody>
{if $maxElement > 0 OR $medium.doc_type_id == 16}
<tr><td class = "editmedia">Medientyp: </td><td> {$doctypetxt} </td>
 <td rowspan="10" >   <input style="width:125px; height:50px;" name="ok" value="&nbsp;&nbsp;&nbsp;SPEICHERN&nbsp;&nbsp;&nbsp;" type="submit"> </td>{* SPEICHERBUTTON: ALLE  *}
</tr>
    {* ORT:  SA fähig UND ( Neues Medium ODER Erwerbungsvorschlag ) *}

    {$scanserviceArticle = false}
    {$scanservicePrint   = false}
    {$semApp             = false}
    {$checked            = ''   }

    {if ( $medium.doc_type_id == 16 ) }  {*Medientyp: unbekannt*}
        {$med_unknown = true}
    {/if}

    {if ($CONF.scanServiceON   AND $medium.doc_type_id == 6 ) }   ## Artikel
      {$scanserviceArticle = true}
    {/if}

    {if ( ($CONF.scanServiceON   AND $medium.sigel == 'HAW-Hamburg' ) AND  ( $medium.doc_type_id == 1 ||  $medium.doc_type_id == 12 ||  $medium.doc_type_id == 13 ||  $medium.doc_type_id == 15  ) )}
      {$scanservicePrint = true}
    {/if}

    {if ($medium.sigel == 'HAW-Hamburg' AND   $medium.doc_type_id != 6   OR $medium.doc_type_id == 99)   }
      {$semApp = true}
    {/if}

    {if ($scanserviceArticle == false AND $scanservicePrint  == false AND $semApp  == false) } {* Wenn Medium ausschließlich als Literaturhinweis angeboten wird, ist dieses  schon  per default ausgewählt *}
        {$checked = 'checked="checked"' } {$c0 = '' }
    {/if}

{if ( $SAready == 1
 AND ( $operator.mode == 'new'
   OR ($medium.doc_type_id == 99
   OR  $medium.doc_type_id == 6  ) ) )
} {*Erwerbungsvorschlag, E-Book, unbekannt*}

  <tr><td  class = "editmedia" style="vertical-align: top; font-weight: bold;">  Ort:  <span style="color: {$color}; vertical-align: top; font-weight: bold;">(bitte auswählen)</span> </td><td>
    <div style="border:{$bw}px solid {$color}; float: left;  height:80px; padding: 3px; padding-right: 8px; font-size: 12px; width: calc(100% - 15px); ">

        {if  ( $medium.sigel == 'HAW-Hamburg' ) OR $medium.doc_type_id == 99 }
            <input {$c2} value="2" class='i' type="radio" name="location_id" id="radio-2" {$checked}><label style="text-align: left; font-weight:700;" for="radio-2"><span "> Literaturhinweis - verbleibt im Regal der Bibliothek.     </span></label><br/>
        {else}
            <input {$c2} value="5" class='i' type="radio" name="location_id" id="radio-5" {$checked}><lab1el style="text-align: left; font-weight:700;" for="radio-5"><span "> Titel nicht aus HAW-Bestand, daher Literaturhinweis   </span></lab1el><br/>
        {/if}

        {if $semApp}
      <input {$c1} value="1" class='i' type="radio" name="location_id" id="radio-1"><label for="radio-1" style="text-align: left; font-weight:700; "><span> Semesterapparat  -  wird in Ihren phys. Semesterapparat eingestellt. </span></label>
      {/if}

      {if $scanservicePrint}
      <input {$c3} value="4" class='i' type="radio" name="location_id" id="radio-3"><label for="radio-3" style="text-align: left; font-weight:700; "><span> Scanauftrag  - Teile dieses Printmediums als PDF. </span></label>
      {/if}

      {if $scanserviceArticle}
      <input {$c4} value="4" class='i' type="radio" name="location_id" id="radio-4"><label for="radio-4" style="text-align: left; font-weight:700;" ><span> Scanauftrag  -  Diesen Artikel als PDF. </span></label>
      {/if}

      <input {$c0} value="0"           type="radio" name="location_id" id="radio-1" style="visibility: hidden;">
    </div>
   </tr>
{/if}

{* Wenn KEIN Erwerbungsvorschlag *}
{if ($medium.doc_type_id != 99 ) }  {* doc_type 99 = Erwerbungsvorschlag *}
  {* Titel, Autor*}
  <tr><td class = "editmedia">Titel:    </td><td><textarea  cols="60" rows="2"    name="title">{$medium.title}</textarea>           </td></tr>
  <tr><td class = "editmedia">Autor:    </td><td><input size="50" value="{$medium.author}"     {$restricted} name="author">         </td></tr>

  {* ISBN, Signatur: Wenn Medientyp BUCH *}
  {if ($medium.doc_type_id == 1)  } {* doc_type 1 = Buch *}
  <tr><td class = "editmedia">ISBN:    </td><td><input size="50" value="{$medium.ISBN}"             {$restricted} name = "ISBN">    </td></tr>
  <tr><td class = "editmedia">Signatur:</td><td><input size="20" value="{$medium.signature|escape}" {$restricted} name = "signature"></td></tr>
  {/if}

  {* Info für Studis *}
  <tr><td class = "editmedia">Anmerkung <br>f&uuml;r Studierende:<br/>(Optional)</td><td><textarea  cols="60" rows="5"    name="notes_to_studies">{$medium.notes_to_studies|escape}</textarea>                      </td></tr>
{/if}


{* Infos für die BIB: Wenn SA-fähiges Medium ODER Erwerbugnsvorschlag  *}
{if $DOC_TYPE[ $medium.doc_type_id ]['SA-ready']  == 1 OR $medium.doc_type_id == 99 } {* doc_type 1 = Buch oder CD im SA *}
<tr>
    {if ($medium.doc_type_id == 99 ) }  <td class = "editmedia"> Ihr Erwerbungs-<br/>vorschlag:                                     </td>
    {else}                              <td class = "editmedia"> Anmerkung <br/>f&uuml;r die Bibliothek:<br/>(Optional)                  </td>
    {/if}
                                        <td><p class="para">Bitte geben Sie hier die zu scannenden Seiten an:</p> <textarea cols="60" rows="5" name="notes_to_staff">{$medium.notes_to_staff|escape}</textarea> 	 </td></tr>
{/if}

{else}<tr><td>
    <input type = "hidden" name = "dc_collection_id" value = "{$collection.dc_collection_id}" >
    <input type = "hidden" name = "item"             value = "collection"                          >
    <input type = "hidden" name = "loc"              value = "1"                              >   {* loc ist an dieser Stelle noch nicht definiert, deshalb standard = 1 *}
    <input type = "hidden" name = "action"           value = "show_collection"                           >
    </td>
    </tr>
    <tr><td> Keine neue Medien oder die Medien sind bereits im Semesterapparat vorhanden. </td>
        <td rowspan="10" >   <input style="width:125px; height:50px;" name="ok" value="&nbsp;&nbsp;&nbsp;Weiter&nbsp;&nbsp;&nbsp;" type="submit"> </td>
    </tr>
{/if}


{if $user.role_id <= 2 AND $medium.id != 0  AND $CONF.show_set_location}
<tr>
    <td style="vertical-align: top;  "><span  class="editmedia">Medienort:</span></td>
    <td style="  border:{$bw}px solid {$color}; float: left;  height:20px; padding: 5px; font-size: 12px; width: calc(100% - 15px); "><span  class="editmedia"> {html_options name="location_id" options=$MEDIALOC selected=$medium.location_id }</td></div>
</tr>


<tr>
    <td style="vertical-align: top;  "><span  class="editmedia">Medienstatus:</span></td>
    <td style="  border:{$bw}px solid {$color}; float: left;  height:20px; padding: 5px; font-size: 12px; width: calc(100% - 15px); "><span  class="editmedia"> {html_options name="state_id" options=$MEDIASTATE selected=$medium.state_id }</td></div>
</tr>

{/if}

</tbody>
</table>
<br>
  <script>
      $( function() { $( ".i" ).checkboxradio( );	} );
      $(document).ready(function()
      {
          $( "#radio-1" ).click( function( ){ $( "p.para" ).hide( ); } );
          $( "#radio-2" ).click( function( ){ $( "p.para" ).hide( ); } );
          $( "#radio-3" ).click( function( ){ $( "p.para" ).show() ; } );
      });
  </script>
</form>
</div>