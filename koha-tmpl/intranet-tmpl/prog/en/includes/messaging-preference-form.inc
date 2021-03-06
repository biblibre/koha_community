<!-- snippet for form to set borrower and patron category messaging preferences -->
<script type="text/javascript">//<![CDATA[
	$(document).ready(function(){
		$(".none").click(function(){
			if($(this).attr("checked")){
				var rowid = $(this).attr("id");
				newid = Number(rowid.replace("none","")) 
			  	$("#sms"+newid).attr("checked","");
			  	$("#email"+newid).attr("checked","");
			  	$("#digest"+newid).attr("checked","");
			  	$("#rss"+newid).attr("checked","");
			}
		});
	});
//]]>
</script>

<input type="hidden" name="modify" value="yes" />
<input type="hidden" name="borrowernumber" value="[% borrowernumber %]" />
  <table>
    <tr><th></th>
        <th>Days in advance</th>
        [% IF ( SMSSendDriver ) %]<th>SMS</th>[% END %]
        <th>Email</th><th>Digests only?</th>
        <!-- <th>RSS</th> -->
        [% UNLESS ( messaging_form_inactive ) %]<th>Do not notify</th>[% END %]
    </tr>
    [% FOREACH messaging_preference IN messaging_preferences %]
    <tr>
      <td>[% IF ( messaging_preference.Item_Due ) %]Item Due
          [% ELSIF ( messaging_preference.Advance_Notice ) %]Advance Notice
          [% ELSIF ( messaging_preference.Upcoming_Events ) %]Upcoming Events
          [% ELSIF ( messaging_preference.Hold_Filled ) %]Hold Filled
          [% ELSIF ( messaging_preference.Item_Check_in ) %]Item Check-in
          [% ELSIF ( messaging_preference.Item_Checkout ) %]Item Checkout
          [% ELSE %]Unknown [% END %]</td>
      [% IF ( messaging_preference.takes_days ) %]
      <td>
          [% IF ( messaging_form_inactive ) %]
            <select name="[% messaging_preference.message_attribute_id %]-DAYS" disabled="disabled">
          [% ELSE %]
            <select name="[% messaging_preference.message_attribute_id %]-DAYS">
          [% END %]
          [% FOREACH select_day IN messaging_preference.select_days %]
          [% IF ( select_day.selected ) %]<option value="[% select_day.day %]" selected="selected">[% select_day.day %]</option>[% ELSE %]
          <option value="[% select_day.day %]">[% select_day.day %]</option>
      [% END %]
          [% END %]
        </select>
      </td>
      [% ELSE %]
      <td>-</td>
      [% END %]
      [% IF ( messaging_preference.transport_sms ) %]
      [% IF ( SMSSendDriver ) %]<td>
          [% IF ( messaging_form_inactive ) %]
              [% IF ( messaging_preference.transports_sms ) %]
                 <input type="checkbox"
                 id="sms[% messaging_preference.message_attribute_id %]"
                 name="[% messaging_preference.message_attribute_id %]"
                 value="sms" checked="checked" disabled="disabled" />
              [% ELSE %]
                 <input type="checkbox"
                 id="sms[% messaging_preference.message_attribute_id %]"
                 name="[% messaging_preference.message_attribute_id %]"
                 value="sms" disabled="disabled" />
              [% END %]
          [% ELSE %]
              [% IF ( messaging_preference.transports_sms ) %]
                 <input type="checkbox"
                 id="sms[% messaging_preference.message_attribute_id %]"
                 name="[% messaging_preference.message_attribute_id %]"
                 value="sms" checked="checked" onclick = "$('#none'+'[% messaging_preference.message_attribute_id %]').attr('checked','');" />
              [% ELSE %]
                 <input type="checkbox"
                 id="sms[% messaging_preference.message_attribute_id %]"
                 name="[% messaging_preference.message_attribute_id %]"
                 value="sms" onclick = "$('#none'+'[% messaging_preference.message_attribute_id %]').attr('checked','');" />
              [% END %]
          [% END %]
      </td>[% END %]
      [% ELSE %]
      <td>-</td>
      [% END %]

      [% IF ( messaging_preference.transport_email ) %]
      <td>
          [% IF ( messaging_form_inactive ) %]
              [% IF ( messaging_preference.transports_email ) %]
                <input type="checkbox"
                   id="email[% messaging_preference.message_attribute_id %]"
                   name="[% messaging_preference.message_attribute_id %]"
                   value="email" checked="checked" disabled="disabled" />
              [% ELSE %]
                <input type="checkbox"
                   id="email[% messaging_preference.message_attribute_id %]"
                   name="[% messaging_preference.message_attribute_id %]"
                   value="email" disabled="disabled" />
              [% END %]
          [% ELSE %]
              [% IF ( messaging_preference.transports_email ) %]
            <input type="checkbox"
                 id="email[% messaging_preference.message_attribute_id %]"
                 name="[% messaging_preference.message_attribute_id %]"
                 value="email" checked="checked" onclick = "$('#none'+'[% messaging_preference.message_attribute_id %]').attr('checked','');" />
              [% ELSE %]
            <input type="checkbox"
                 id="email[% messaging_preference.message_attribute_id %]"
                 name="[% messaging_preference.message_attribute_id %]"
                 value="email" onclick = "$('#none'+'[% messaging_preference.message_attribute_id %]').attr('checked','');" />
              [% END %]
          [% END %]
      </td>
      [% ELSE %]
      <td>-</td>
      [% END %]

      [% IF ( messaging_preference.has_digest ) %]
      <td>
          [% IF ( messaging_form_inactive ) %]
              [% IF ( messaging_preference.digest ) %]
                <input type="checkbox"
                     id="digest[% messaging_preference.message_attribute_id %]"
                     value="[% messaging_preference.message_attribute_id %]"
                     name="digest" checked="checked" disabled="disabled" />
              [% ELSE %]
                <input type="checkbox"
                     id="digest[% messaging_preference.message_attribute_id %]"
                     value="[% messaging_preference.message_attribute_id %]"
                     name="digest" disabled="disabled" />
              [% END %]
          [% ELSE %]
              [% IF ( messaging_preference.digest ) %]
                <input type="checkbox"
                     id="digest[% messaging_preference.message_attribute_id %]"
                     value="[% messaging_preference.message_attribute_id %]"
                     name="digest" checked="checked" onclick = "$('#none'+'[% messaging_preference.message_attribute_id %]').attr('checked','');" />
              [% ELSE %]
                <input type="checkbox"
                     id="digest[% messaging_preference.message_attribute_id %]"
                     value="[% messaging_preference.message_attribute_id %]"
                     name="digest" onclick = "$('#none'+'[% messaging_preference.message_attribute_id %]').attr('checked','');" />
              [% END %]
          [% END %]
      </td>
      [% ELSE %]
      <td>-</td>
      [% END %]

<!--       [% IF ( messaging_preference.transport_rss ) %]
      <td>
          [% IF ( messaging_form_inactive ) %]
            <input type="checkbox"
                 id="rss[% messaging_preference.message_attribute_id %]"
                 name="[% messaging_preference.message_attribute_id %]"
                 value="rss"   [% messaging_preference.transport_rss %] disabled="disabled" />
          [% ELSE %]
            <input type="checkbox"
                 id="rss[% messaging_preference.message_attribute_id %]"
                 name="[% messaging_preference.message_attribute_id %]"
                 value="rss"   [% messaging_preference.transport_rss %] onclick = "$('#none'+'[% messaging_preference.message_attribute_id %]').attr('checked','');" />
          [% END %]
      </td>
      [% ELSE %]
      <td>-</td>
      [% END %] -->

      [% UNLESS ( messaging_form_inactive ) %]
      <td><input type="checkbox" class="none" id="none[% messaging_preference.message_attribute_id %]" /></td>
      [% END %]
    </tr>
    [% END %]
  </table>
