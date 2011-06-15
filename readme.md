# Reach Stats

Framework use in the [Reach Service Record iOS & Android App](http://reachservicerecord.com) app.

## Requires

* [YAJL ObjC](https://github.com/gabriel/yajl-objc)
* No longer requires ASIHTTPRequest

## Usage

Add the following to your delegate: 
> NSString * const rsAPIKey = @"your_api_key"; 

If you do not have an API key, you can receive one in your profile page @ Bungie.net
* Use the requests found in the requests folder to get the information you want from the API
** For the time being read the headers... it is documented fairly well i think...
** In the future I will try generate some better documentation... I promise :D

## Future

* Some of the request still do not work asynchronously
* Request queue with NSOperationQueue
* Probably not much more... Unless you fork it and make some additions :D
