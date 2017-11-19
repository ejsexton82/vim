<?php

class TTCLASSController extends Controller {

    public function filters() 
    {
        return [
            'https',
            'accessControl',
        ];
    }

    public function accessRules() 
    {
        return [
            [
                'allow',
                'actions' => [
                    // Anonymous Actions
                ],
                'users' => ['*'],
            ],
            [
                'allow',
                'actions' => [
                    // Logged In Actions
                ],
                'users' => ['@'],
            ],
            [
                'deny',
                'controllers' => [
                    $this->id
                ],
                'users' => ['*'],
            ]
        ];
    }
}

if (!TT::classExists('CLASSController')) {

    class CLASSController extends TTCLASSController {

    }

}
