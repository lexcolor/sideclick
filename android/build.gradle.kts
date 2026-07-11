allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    // Force all plugin subprojects to compile against a modern SDK. Some plugins
    // (e.g. file_picker) still target android-34, which conflicts with others
    // (flutter_plugin_android_lifecycle) that require compileSdk 36+. This must
    // run before :app is evaluated below.
    afterEvaluate {
        extensions.findByType<com.android.build.gradle.BaseExtension>()?.apply {
            val current = compileSdkVersion
                ?.substringAfter("android-")
                ?.toIntOrNull()
            if (current == null || current < 36) {
                compileSdkVersion(36)
            }
        }
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
