<?php
namespace App\Repositories;

use App\Models\Categorie;
use App\utils\UploadUtil;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class CategorieRepository extends ResourceRepository {

    protected $uploadUtil;
    public function __construct(Categorie $categorie, UploadUtil $uploadUtil)
    {
        $this->model = $categorie;
        $this->uploadUtil = $uploadUtil;
    }

    public function save(Request $request) {
        $inputs = $request->all();

        $this->model->libelle = $inputs['libelle'];
        if($request->hasFile(('icon'))){
            $this->model->icon = $this->uploadUtil->uploadFile($request->file('icon'));
        }

        try{
            $this->model->save();
            return $this->model;
        }catch(QueryException | \Throwable $e){
            Log::info('ERREUR CREATION CATEGORIE: ' . $e);
            return null;
        }
    }
}
