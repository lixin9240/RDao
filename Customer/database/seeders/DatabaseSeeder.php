<?php

namespace Database\Seeders;

use App\Models\SysUser;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            CustomerAddressSeeder::class,
            CustomerFeeSeeder::class,
        ]);

        $users = [
            [
                'username'           => 'LX',
                'password'           => '123456',
                'real_name'          => 'LX',
                'gender'             => 1,
                'dept_id'            => 1,
                'job_title'          => '开发人员',
                'email'              => 'lx@example.com',
                'phone'              => '13800000001',
                'professional_level' => 'LEVEL_A',
                'business_level'     => 'LEVEL_A',
                'employment_status'  => 1,
                'account_status'     => 1,
            ],
            [
                'username'           => 'WJC',
                'password'           => '123456',
                'real_name'          => 'WJC',
                'gender'             => 1,
                'dept_id'            => 1,
                'job_title'          => '开发人员',
                'email'              => 'wjc@example.com',
                'phone'              => '13800000002',
                'professional_level' => 'LEVEL_A',
                'business_level'     => 'LEVEL_A',
                'employment_status'  => 1,
                'account_status'     => 1,
            ],
            [
                'username'           => 'Fmy',
                'password'           => '123456',
                'real_name'          => 'Fmy',
                'gender'             => 2,
                'dept_id'            => 1,
                'job_title'          => '开发人员',
                'email'              => 'fmy@example.com',
                'phone'              => '13800000003',
                'professional_level' => 'LEVEL_A',
                'business_level'     => 'LEVEL_A',
                'employment_status'  => 1,
                'account_status'     => 1,
            ],
            [
                'username'           => 'Gyz',
                'password'           => '123456',
                'real_name'          => 'Gyz',
                'gender'             => 1,
                'dept_id'            => 1,
                'job_title'          => '开发人员',
                'email'              => 'gyz@example.com',
                'phone'              => '13800000004',
                'professional_level' => 'LEVEL_B',
                'business_level'     => 'LEVEL_B',
                'employment_status'  => 1,
                'account_status'     => 1,
            ],
        ];

        foreach ($users as $user) {
            SysUser::create($user);
        }
    }
}
