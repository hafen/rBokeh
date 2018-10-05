// https://github.com/bermi/jsonp-client
// MIT License
// Copyright (c) 2013 Bermi Ferrer <bermi@bermilabs.com>
(function(root){"use strict";var previousJsonpClient=root.jsonpClient,is_browser=typeof process!=="undefined"?process.browser:typeof window!=="undefined",getJsonpBrowser,getJsonp,CALLBACK_REGEXP=/[\?|&]callback=([a-z0-9_]+)/i,jsonpClient=function(){var args=Array.prototype.slice.apply(arguments),callback,urls=args.slice(0,-1),i=0,error,results=[],addUrl,returnResult;try{callback=args.slice(-1)[0];if(typeof callback!=="function"){throw new Error("Callback not found")}}catch(e){throw new Error("jsonpClient expects a callback")}if(typeof urls[0]!=="string"){urls=urls[0]}returnResult=function(){var i=0;results=results.sort(function(a,b){return a.position>b.position});for(i=0;results.length>i;i=i+1){results[i]=results[i].data}results.unshift(null);callback.apply(null,results)};addUrl=function(url,position){getJsonp(urls[i],function(err,data){if(error){return}error=err;if(err){return callback(err)}results.push({data:data,position:position});if(results.length===urls.length){returnResult()}})};for(i=0;urls.length>i;i=i+1){addUrl(urls[i]+"",i)}};jsonpClient.noConflict=function(){root.jsonpClient=previousJsonpClient;return jsonpClient};getJsonpBrowser=function(){var getCallbackFromUrl,loadScript,head=document.getElementsByTagName("head")[0];loadScript=function(url,callback){var script=document.createElement("script"),done=false;script.src=url;script.async=true;script.onload=script.onreadystatechange=function(){if(!done&&(!this.readyState||this.readyState==="loaded"||this.readyState==="complete")){done=true;script.onload=script.onreadystatechange=null;if(script&&script.parentNode){script.parentNode.removeChild(script)}callback()}};head.appendChild(script)};getCallbackFromUrl=function(url,callback){var matches=url.match(CALLBACK_REGEXP);if(!matches){return callback(new Error("Could not find callback on URL"))}callback(null,matches[1])};return function(url,callback){getCallbackFromUrl(url,function(err,callbackName){var data,originalCallback=window[callbackName];if(err){return callback(err)}window[callbackName]=function(jsonp_data){data=jsonp_data};loadScript(url,function(err){if(!err&&!data){err=new Error("Calling to "+callbackName+" did not return a JSON response."+"Make sure the callback "+callbackName+" exists and is properly formatted.")}if(originalCallback){window[callbackName]=originalCallback}else{try{delete window[callbackName]}catch(ex){window[callbackName]=undefined}}callback(err,data)})})}};getJsonp=is_browser?getJsonpBrowser():require("./jsonp-node.js");if(typeof module!=="undefined"&&module.exports){module.exports=jsonpClient}else{root.jsonpClient=jsonpClient}})(this);
// end jsonp-client

$(window).load(function() {

  var elements = $('.lazy-widget');

  // sort elements by how close they are to current position
  var curPos = $(window).scrollTop();
  elements.sort(function(a, b) {
    return Math.abs($(a).offset().top - curPos) - Math.abs($(b).offset().top - curPos);
  });

  var process = function() {
    if (elements.length == 0) {
      return;
    }

    var x = elements[0];
    elements.splice(0, 1);

    var id = $(x).attr('id');

    var cb = 'cb' + id.replace('htmlwidget-', '');
    window[cb] = function(json) {
      return(json);
    }

    jsonpClient('lazy_widgets/' + id + '.jsonp?callback=' + cb, function(err, json) {
      if (err) {
        console.error(err);
      }
      $('#' + json.id).addClass(json.class);
      $('#' + json.id).removeClass('lazy-loading');
      $('#' + json.sid).html(json.script);
      window.HTMLWidgets.staticRender();
      process();
    });
  }

  process();
});
