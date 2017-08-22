/*
* UltraDefrag reports sorting engine.
* Copyright (C) 2008-2013 Dmitri Arkhangelski (dmitriar@gmail.com).
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

/*
* Interface:
* 1. init_sorting_engine()
* 2. sort_items(criteria), where criteria is 
*  {"fragments" | "size" | "name" | "comment" | "status"}
*/

/* global variables */
var
 table,
 whitelist,
 blacklist,
 // order = 0 - descending; 1 - ascending
 order = 0,
 fragments_order = 1,
 size_order = 1,
 name_order = 0,
 comment_order = 1,
 status_order = 1,
 msie_browser = false, // true for ms internet explorer
 table_head = "$TABLE_HEAD";  // the report converter adjusts it

function init_sorting_engine()
{
 table = document.getElementById("main_table");
 if(window.navigator.appName === "Microsoft Internet Explorer")
  msie_browser = true;
}

function sort_by_fragments(a,b)
{
 var
  fa = parseInt(a.getElementsByTagName("td")[0].innerHTML),
  fb = parseInt(b.getElementsByTagName("td")[0].innerHTML);
 return (fragments_order) ? (fa - fb) : (fb - fa);
}

function sort_by_size(a,b)
{
 var
  fa = parseInt(a.getElementsByTagName("td")[1].id),
  fb = parseInt(b.getElementsByTagName("td")[1].id);
 return (size_order) ? (fa - fb) : (fb - fa);
}

function sort_by_name(a,b)
{
 var
  na = a.getElementsByTagName("td")[2].innerHTML.toLowerCase(),
  nb = b.getElementsByTagName("td")[2].innerHTML.toLowerCase(),
  result = (na > nb) ? 1 : (na === nb) ? 0 : -1;
 return (name_order) ? -result : result;
}

function sort_by_comment(a,b)
{
 var
  ca = a.getElementsByTagName("td")[3].innerHTML.toLowerCase(),
  cb = b.getElementsByTagName("td")[3].innerHTML.toLowerCase(),
  result = (ca > cb) ? 1 : (ca === cb) ? 0 : -1;
 return (comment_order) ? -result : result;
}

function sort_by_status(a,b)
{
 var
  ca = a.getElementsByTagName("td")[4].innerHTML.toLowerCase(),
  cb = b.getElementsByTagName("td")[4].innerHTML.toLowerCase(),
  result = (ca > cb) ? 1 : (ca === cb) ? 0 : -1;
 return (status_order) ? -result : result;
}

function sort_items(criteria)
{
 whitelist = "";
 blacklist = "";
 var
  i,
  data,
  a = [],
  items = table.getElementsByTagName("tr"),
  header = "<tr>" + items[0].innerHTML + "</tr>\n";

 // convert the collection to an array
 for(i = 1; i < items.length; i++)
  a[i-1] = items[i];

 // sort items
 // Note that sorting is slow: about 1.5
 // seconds for 550 items on 1.8GHz CPU.
 if(criteria === 'fragments'){
  a.sort(sort_by_fragments);
  fragments_order = fragments_order ? 0 : 1;
 } else if(criteria === 'size'){
  a.sort(sort_by_size);
  size_order = size_order ? 0 : 1;
 } else if(criteria === 'name'){
  a.sort(sort_by_name);
  name_order = name_order ? 0 : 1;
 } else if(criteria === 'comment'){
  a.sort(sort_by_comment);
  comment_order = comment_order ? 0 : 1;
 } else if(criteria === 'status'){
  a.sort(sort_by_status);
  status_order = status_order ? 0 : 1;
 } else
  return; // invalid criteria

 // loop through the array of sorted items
 for(i = 0; i < a.length; i++){
  data = a[i].innerHTML;
  if(a[i].className === "u")
   whitelist += "<tr class=\"u\">" + data + "</tr>\n";
  else
   blacklist += "<tr class=\"f\">" + data + "</tr>\n";
 }

 // replace the old contents with the new sorted one
 if(!msie_browser){
  table.innerHTML = header + whitelist + blacklist;
 } else {
  // On Internet Explorer the table.innerHTML is read only,
  // so we need to replace the whole table ...
  document.getElementById("for_msie").innerHTML =
   table_head + header + whitelist + blacklist + "</table>";
  table = document.getElementById("main_table");
 }
}
