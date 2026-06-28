<?php

namespace App\Services;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use OSS\OssClient;
use OSS\Core\OssException;

class OssService
{
    protected ?OssClient $client = null;
    protected string $bucket = '';
    protected string $endpoint = '';
    protected string $cdnDomain = '';

    public function __construct()
    {
        $this->bucket = config('filesystems.disks.oss.bucket', '');
        $this->endpoint = config('filesystems.disks.oss.endpoint', '');
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
     * @return array{path: string, size: int, original_name: string}
     */
    public function upload(UploadedFile $file, string $directory = 'uploads'): array
    {
        $originalName = $file->getClientOriginalName();
        $extension = $file->getClientOriginalExtension();
        $fileName = uniqid() . '_' . time() . '.' . $extension;
        $object = $directory . '/' . $fileName;

        $this->getClient()->uploadFile($this->bucket, $object, $file->getRealPath());

        return [
            'path'          => $object,
            'size'          => $file->getSize(),
            'original_name' => $originalName,
        ];
    }

    /**
     * 对 OSS object 路径进行编码，确保中文和特殊字符正确处理
     */
    protected function encodeObject(string $object): string
    {
        $object = ltrim($object, '/');
        // 按路径分段编码，保留斜杠
        return implode('/', array_map('rawurlencode', explode('/', $object)));
    }

    /**
     * 获取文件访问 URL
     */
    public function getUrl(string $object, int $expires = 3600): string
    {
        $object = $this->encodeObject($object);

        if ($this->cdnDomain) {
            return rtrim($this->cdnDomain, '/') . '/' . $object;
        }

        return $this->getClient()->signUrl($this->bucket, $object, $expires);
    }

    /**
     * 获取文件下载链接
     */
    public function getDownloadUrl(string $object, string $originalName, int $expires = 3600): string
    {
        $object = $this->encodeObject($object);
        $options = [
            'response-content-disposition' => 'attachment; filename="' . urlencode($originalName) . '"',
        ];

        return $this->getClient()->signUrl($this->bucket, $object, $expires, 'GET', $options);
    }

    /**
     * 获取文件预览链接（浏览器直接打开，不下载）
     */
    public function getPreviewUrl(string $object, int $expires = 3600): string
    {
        $object = $this->encodeObject($object);
        $options = [
            'response-content-disposition' => 'inline',
        ];

        return $this->getClient()->signUrl($this->bucket, $object, $expires, 'GET', $options);
    }

    /**
     * 删除 OSS 文件
     */
    public function delete(string $object): void
    {
        $this->getClient()->deleteObject($this->bucket, $object);
    }
}
