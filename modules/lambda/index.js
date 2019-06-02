'use strict';
console.log('Loading function');

let aws = require('aws-sdk');
let s3 = new aws.S3({ apiVersion: '2006-03-01' });

exports.handler = (event, context, callback) => {
    console.log('Received event:', JSON.stringify(event, null, 2));
    if (!event['bucket'] ){
        return context.fail("bucket needs to be provided");
    }
    if (!event['key']){
        return context.fail("key needs to be provided");
    }
    var params = {
        Bucket: event['bucket'],
        Key: event['key']
    };
    // it would be cute to include a expiry time
    // todo: validate because the client needs to use it
    s3.getSignedUrl('getObject', params, function (err, url) {
        console.log("url:"+url);
        console.log("err:" + err);
        return context.succeed({"signed_url": url});
    });

};
