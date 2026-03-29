allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

fun inferNamespaceFromManifest(project: Project): String? {
    val manifestFile = project.file("src/main/AndroidManifest.xml")
    if (!manifestFile.exists()) return null

    val match = Regex("""package="([^"]+)"""")
        .find(manifestFile.readText())

    return match?.groupValues?.getOrNull(1)
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
    project.evaluationDependsOn(":app")
}

fun applyNamespaceFallback(project: Project) {
    val androidExtension = project.extensions.findByName("android") ?: return
    val getNamespace = androidExtension.javaClass.methods.firstOrNull { it.name == "getNamespace" }
    val setNamespace = androidExtension.javaClass.methods.firstOrNull { it.name == "setNamespace" }
    val currentNamespace = getNamespace?.invoke(androidExtension) as? String

    if (currentNamespace.isNullOrBlank()) {
        val inferredNamespace = inferNamespaceFromManifest(project)
        if (!inferredNamespace.isNullOrBlank()) {
            setNamespace?.invoke(androidExtension, inferredNamespace)
        }
    }
}

subprojects {
    pluginManager.withPlugin("com.android.library") {
        applyNamespaceFallback(this@subprojects)
    }
    pluginManager.withPlugin("com.android.application") {
        applyNamespaceFallback(this@subprojects)
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
