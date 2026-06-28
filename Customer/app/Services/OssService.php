<?php

namespace App\Services;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use OSS\OssClient;
use OSS\Core\OssException;

class OssService
{
    protected ?OssClient $client = null;
    protected string $bucket;
    protected string $endpoint;
    protected string $cdnDomain;

    public function __construct()
    {
        $this->bucket = config('filesystems.disks.oss.bucket');
        $this->endpoint = config('filesystems.disks.oss.endpoint');
        $this->cdnDomain = config('filesystems.disks.oss.cdn_domain', '');
    }

    /**
     * 获取 OSS 客户端
     */
    protected function getClient(): OssClient
    {
        if ($this->client === null) {
            $accessKeyId = config('filesystems.disks.oss.access_key_id');
            $accessKeySecret = config('filesystems.disks.oss.access_key_secret');
            $endpoint = $this->endpoint;

            $this->client = new OssClient($accessKeyId, $accessKeySecret, $endpoint);
        }

        return $this->client;
    }

    /**
     * 上传文件到 OSS
     *
     * @param UploadedFile $file 上传的文件
     * @param string $directory 存储目录
     * @return array 包含 path、url、size 的数组
     * @throws \Exception
     */
    public function upload(UploadedFile $file, string $directory = 'uploads'): array
    {
        try {
            // 生成唯一文件名
            $extension = $file->getClientOriginalExtension();
            $filename = $this->generateUniqueFilename($extension);
            $object = trim($directory, '/') . '/' . date('Y/m/d') . '/' . $filename;

            // 上传文件
            $this->getClient()->uploadFile(
                $this->bucket,
                $object,
                $file->getRealPath()
            );

            return [
                'path' => $object,
                'url' => $this->getUrl($object),
                'size' => $file->getSize(),
                'original_name' => $file->getClientOriginalName(),
            ];
        } catch (OssException $e) {
            throw new \Exception('OSS 上传失败: ' . $e->getMessage());
        }
    }

    /**
     * 上传本地文件到 OSS
     *
     * @param string $localPath 本地文件路径
     * @param string $directory 存储目录
     * @return array
     * @throws \Exception
     */
    public function uploadLocalFile(string $localPath, string $directory = 'uploads'): array
    {
        try {
            $extension = pathinfo($localPath, PATHINFO_EXTENSION);
            $filename = $this->generateUniqueFilename($extension);
            $object = trim($directory, '/') . '/' . date('Y/m/d') . '/' . $filename;

            $this->getClient()->uploadFile(
                $this->bucket,
                $object,
                $localPath
            );

            return [
                'path' => $object,
                'url' => $this->getUrl($object),
                'size' => filesize($localPath),
            ];
        } catch (OssException $e) {
            throw new \Exception('OSS 上传失败: ' . $e->getMessage());
        }
    }

    /**
     * 删除 OSS 文件
     *
     * @param string $object 文件路径
     * @return bool
     */
    public function delete(string $object): bool
    {
        try {
            $this->getClient()->deleteObject($this->bucket, $object);
            return true;
        } catch (OssException $e) {
            return false;
        }
    }

    /**
     * 检查文件是否存在
     *
     * @param string $object
     * @return bool
     */
    public function exists(string $object): bool
    {
        try {
            return $this->getClient()->doesObjectExist($this->bucket, $object);
        } catch (OssException $e) {
            return false;
        }
    }

    /**
     * 获取文件访问 URL
     *
     * @param string $object
     * @param int $timeout 签名 URL 有效期（秒），0 表示永久
     * @return string
     */
    public function getUrl(string $object, int $timeout = 0): string
    {
        // 如果配置了 CDN 域名，使用 CDN
        if ($this->cdnDomain) {
            return rtrim($this->cdnDomain, '/') . '/' . $object;
        }

        // 如果是私有 bucket，生成签名 URL
        if ($timeout > 0) {
            try {
                return $this->getClient()->signUrl($this->bucket, $object, $timeout);
            } catch (OssException $e) {
                return '';
            }
        }

        // 公共 bucket 直接返回 URL
        return 'https://' . $this->bucket . '.' . $this->endpoint . '/' . $object;
    }

    /**
     * 获取文件下载 URL
     *
     * @param string $object
     * @param string $filename 下载时显示的文件名
     * @param int $timeout 有效期（秒）
     * @return string
     */
    public function getDownloadUrl(string $object, string $filename = '', int $timeout = 3600): string
    {
        $options = [];
        if ($filename) {
            $options[OssClient::OSS_HEADERS] = [
                'Content-Disposition' => 'attachment; filename="' . urlencode($filename) . '"'
            ];
        }

        try {
            return $this->getClient()->signUrl($this->bucket, $object, $timeout, 'GET', $options);
        } catch (OssException $e) {
            return '';
        }
    }

    /**
     * 生成唯一文件名
     */
    protected function generateUniqueFilename(string $extension): string
    {
        return uniqid() . '_' . bin2hex(random_bytes(8)) . ($extension ? '.' . $extension : '');
    }
}