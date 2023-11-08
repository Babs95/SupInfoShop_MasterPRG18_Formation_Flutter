<?php

namespace App\Repositories;

use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

abstract class ResourceRepository
{

    protected $model;

    public function getPaginate($n)
    {
        return $this->model->paginate($n);
    }

    public function getPublishedPaginate($n)
    {
        return $this->model->isPublished()->paginate($n);
    }

    public function store(Array $inputs)
    {
        return $this->model->create($inputs);
    }

    public function getData()
    {
        return $this->model->get();
    }

    public function getDataByDate($date)
    {
        return $this->model->where('date','=', $date)->get();
    }

    public function getDataByDateAndState($date,$state)
    {
        return $this->model->where('dateExp','=', $date)
            ->where('state', '=', $state)
            ->get();
    }

    public function getPublishedData()
    {
        return $this->model->isPublished()->get();
    }

    public function getById($id)
    {
        return $this->model->findOrFail($id);
    }

    public function getBySlug($slug)
    {
        try {
            return $this->model->whereSlug($slug)->firstOrFail();
        } catch (QueryException $ex) {
            return abort(404);
        }
    }

    public function getPublishedById($id)
    {
        return $this->model->isPublished()->findOrFail($id);
    }

    public function getPublishedBySlug($slug)
    {
        try {
            return $this->model->isPublished()->where('slug', $slug)->firstOrFail();
        } catch (QueryException $ex) {
            return abort(404);
        }
    }

    public function getSafeById($id)
    {
        return $this->model->find($id);
    }

    public function update($id, Array $inputs)
    {
        $model = $this->getById($id);
        $model->update($inputs);
        return $model;
    }

    public function destroy($id)
    {
        try {
            $this->getById($id)->delete();
            return true;
        } catch (QueryException $e) {
            return false;
        }
    }

    public function getNb()
    {
        return $this->model->count();
    }

    public function updateEtatValidation($id, $etat)
    {
        $model = $this->getById($id);
        if ($model->etat == $etat) return true;
        $model->etat = $etat;
        return $model->save();
    }

    public function publication($id)
    {
        $model = $this->getById($id);
        $model->est_publie = !$model->est_publie;
        return $model->save();
    }

    public function getSlug($chaine)
    {
        $slug = Str::slug(Str::limit($chaine, 150));
        while (!$this->isSlugValid($slug)) {
            $slug .= '-' . rand(1000, 9999);
        }
        return $slug;
    }

    private function isSlugValid($slug)
    {
        $validator = Validator::make(['slug' => $slug], [
            "slug" => 'unique:' . $this->model->getTable() . ',slug'
        ]);

        return !$validator->fails();
    }
}
