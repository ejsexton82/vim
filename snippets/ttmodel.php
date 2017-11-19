<?php

class TTCLASS extends TTFmRecord {

    protected $_layoutName = 'LAYOUT';


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

if (!TT::classExists('CLASS', false)) {

    class CLASS extends TTCLASS {

    }

}
