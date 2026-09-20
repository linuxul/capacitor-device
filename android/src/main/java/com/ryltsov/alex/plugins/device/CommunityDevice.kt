package com.ryltsov.alex.plugins.device

import android.os.Environment
import android.os.StatFs

public class CommunityDevice {
    public val diskFree: Long
        get() = StatFs(Environment.getRootDirectory().absolutePath).run { availableBlocksLong * blockSizeLong }

    public val diskTotal: Long
        get() = StatFs(Environment.getRootDirectory().absolutePath).run { blockCountLong * blockSizeLong }

    public val realDiskFree: Long
        get() = StatFs(Environment.getDataDirectory().absolutePath).run { availableBlocksLong * blockSizeLong }

    public val realDiskTotal: Long
        get() = StatFs(Environment.getDataDirectory().absolutePath).run { blockCountLong * blockSizeLong }
}
