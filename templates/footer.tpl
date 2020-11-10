{* $operator *}
{if $operator.mode != "print"}
{if $operator.action == "show_collection" OR $operator.action == "show_media_list"}
    <script src="lib/jquery.modal.min.js"></script>
    <link  href="lib/jquery.modal.min.css" rel="stylesheet" />
  
    <div id="helpit" class="modal">
        <p class="closeBtn" style="float:right;" > <a href="#" rel="modal:close"><img  class="icon" title="close" src="img/svg/chevron-left.svg" /></a></p>
        <iframe style="width:100%; height:600px;   z-index: 8001; " src="lib/hilfe.html"></iframe>

    </div>
{/if}


    <script type="text/javascript">
        $.modal.defaults = {
            closeExisting: true,    // Close existing modals. Set this to false if you need to stack multiple modal instances.
            escapeClose: true,      // Allows the user to close the modal by pressing `ESC`
            clickClose: true,       // Allows the user to close the modal by clicking the overlay
            closeText: 'Close',     // Text content for the close <a> tag.
            showClose: false,        // Shows a (X) icon/link in the top-right corner
            // HTML appended to the default spinner during AJAX requests.
            fadeDelay: 1.0          // Point during the overlay's fade-in that the modal begins to fade in (.5 = 50%, 1.5 = 150%, etc.)
        };
    </script>

</body>
</html>
{/if}
