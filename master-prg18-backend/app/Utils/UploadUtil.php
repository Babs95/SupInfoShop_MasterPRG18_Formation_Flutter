<?php

namespace App\utils;

use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class UploadUtil
{
    const CATEGORIE_ICON_PATH = '/images/categories';
    const PRODUIT_IMAGE_PATH = '/images/produits';
    const AVATAR_USER_PATH = '/images/user';
    const DEFAUL_PATH = '/images/default';
    protected $repertoire;

    public function __construct()
    {
        $this->repertoire = self::CATEGORIE_ICON_PATH;
    }

    public function uploadFile($fichier , $mode = "categorie"){
        if($mode != "categorie")
            $this->repertoire = $this->selectPath($mode);

        //Generation Nom Fichier
        $timestamp = str_replace([' ',':'], '-', Carbon::now()->toDateTimeString());
        $name = $timestamp . '-' . Str::random(32) . '.' . $fichier->getClientOriginalExtension();

        Storage::disk('public')->putFileAs($this->repertoire, $fichier, $name);

        return $name;
    }

    public function deleteFile($name , $mode = "categorie"){
        if($mode != "categorie")
            $this->repertoire = $this->selectPath($mode);

        //Suppression du fichier
        $filePath = $this->repertoire . '/' .$name;

        if(Storage::disk('public')->exists($filePath)){
            Storage::disk('public')->delete($filePath);
            return true;
        }

        return false;
    }

    private function selectPath($mode) {
        switch ($mode) {
            case 'categorie':
                return self::CATEGORIE_ICON_PATH;
            case 'produit':
                return self::PRODUIT_IMAGE_PATH;
            case 'avatar':
                return self::AVATAR_USER_PATH;
            default:
                return self::DEFAUL_PATH;
        }
    }
}
