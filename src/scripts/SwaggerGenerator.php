<?php

/* 
 * A script to generate the swagger JSON documentation.
 */

require_once(__DIR__ . '/../bootstrap.php');

class SwaggerGenerator
{
    public static function main()
    {
        $document = new \iRAP\Swagger\Document(
            "CSV Validator", 
            "A validation service written in PHP and deployed through docker.", 
            $host = "validator.mydomain.com", 
            "1.0.0", 
            $schemes = array("http", "https"), 
            $basePath = "/api"
        );

        $path = new \iRAP\Swagger\Path("/validate");

        $validateAction = new iRAP\Swagger\PathAction(
            "post", 
            "Add a validation request to the queu", 
            "Add a validation request to the queu"
        );
        
        $successResponse = new \iRAP\Swagger\Response(200, "Validation succeeded.");
        $validateAction->addResponse($successResponse);
        $path->addAction($validateAction);
        $document->addPath($path);

        file_put_contents(__DIR__ . '/../public_html/swagger.json', $document);
        print "Swagger documentation updated. Don't forget to commit." . PHP_EOL;
    }
}

SwaggerGenerator::main();




