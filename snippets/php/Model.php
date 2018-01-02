<?php

class CLASS extends TTCLASS {

    public function getFields() {
        if (!isset($this->_fields)) {
            $this->_fields = array_merge(
                parent::getFields(), 
                [
                    'id' => 'ID',
                ]
            );
        }
        return $this->_fields;
    }

    public function relations()
    {
        return [

        ];
    }
}
