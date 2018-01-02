<?php

class CLASSController extends TTCLASSController {

    public function accessRules() 
    {
        return array_merge(
            [
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
            ],
            parent::accessRules()
        );
    }
}
