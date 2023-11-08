<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\CategorieResource;
use App\Repositories\CategorieRepository;
use Illuminate\Http\Request;

class CategorieController extends Controller
{
    protected $categorieRepository;

    public function __construct(CategorieRepository $categorieRepository)
    {
        $this->categorieRepository = $categorieRepository;
    }

    public function index(){
        $categories = $this->categorieRepository->getData();

        return response(([
            'message' => 'Retrieved succcesfully',
            'categories'=> CategorieResource::collection($categories)
        ]));
    }

    public function store(Request $request){
        $result = $this->categorieRepository->save($request);

        if(!$result){
            return response(([
                'status' => 'ECHEC',
                'message' => 'La création de la catégorie a échouée!',
                'categorie'=> $result
            ]), 400);
        }
        return response(([
            'status' => 'SUCCESS',
            'message' => 'La catégorie a été crée avec succès!',
            'categorie'=> $result
        ]),200);
    }
}
