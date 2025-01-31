<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CompanyProfileController extends Controller
{
    /**
     * 
     *
     * @return \Illuminate\View\View
     */
    public function index()
    {
        
        $companyName = "Bengkel Otomotif Jaya Makmur";
        $companyDescription = "Kami adalah bengkel yang menyediakan berbagai layanan perbaikan dan suku cadang kendaraan bermotor dengan kualitas terbaik.";
        $companyVision = "Menjadi bengkel terpercaya dan terbaik di Indonesia dalam pelayanan dan kualitas produk.";
        $companyMission = "Menyediakan layanan perbaikan dan penggantian suku cadang dengan harga yang bersaing dan pelayanan yang ramah serta profesional.";

        return view('company-profile', compact('companyName', 'companyDescription', 'companyVision', 'companyMission'));
    }
}
